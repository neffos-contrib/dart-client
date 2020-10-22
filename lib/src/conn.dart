import 'package:web_socket_channel/web_socket_channel.dart';

import 'event.dart';
import 'message.dart';
import 'ns_conn.dart';
import 'error.dart';


typedef messageHandlerFunc =  Function(NsConn ns, Message msg);
typedef waitingMessageFunc = void Function(Message msg);

class Conn {
  bool allowNativeMessages;

  final WebSocketChannel channel;

  bool closed;

  Map<String, NsConn> connectedNamespaces;

  String id;

  Map<String, Map<String, messageHandlerFunc>> namespaces;

  int reconnectTries;

  Map<String, void Function()> waitServerConnectNotifiers;

  Map<String, waitingMessageFunc> waitingMessages;

  List<String> queue;

  bool _isAcknowledged;

  Future<NsConn> connect(String namespace) async {
    return this.askConnect(namespace);
  }

  Future<Message> ask(Message msg) async {
    return new Future<Message>(() {
      if (this.isClosed) {
        return Future.error(errorClosed);
      }

      msg.wait = getWait();

      waitingMessageFunc message = (Message receive) {
        if (receive.isError) {
          return Future.error(receive.err);
        }

        return Future.value(receive);
      };

      this.waitingMessages[msg.wait] = message;

      if (!this.write(msg)) {
        return Future.error(errWrite);
      }

      return Future.value(msg);
    });
  }

  Future<NsConn> askConnect(String namespace) async {
    NsConn nsConn = this.namespace(namespace);

    if (nsConn != null) {
      return nsConn;
    }

    Map<String, messageHandlerFunc> events =
        getEvents(this.namespaces, namespace);

    if (events == null) {
      return Future.error(errBadNamespace);
    }

    Message connectMessage = new Message(namespace: namespace, isLocal: true, event: OnNamespaceConnect);

    NsConn ns = new NsConn(conn: this,namespace: namespace,events: events);

    SocketError err = fireEvent(ns, connectMessage);

    if (err != null) {
      return Future.error(err);
    }

    try {
      await this.ask(connectMessage);
    } catch (err) {
      return Future.error(err);
    }

    this.connectedNamespaces[namespace] = ns;

    connectMessage.event = OnNamespaceConnected;

    fireEvent(ns, connectMessage);

    return ns;
  }

  Future<SocketError> askDisconnect(Message msg) async {
    // TODO: implement askDisconnect
    throw UnimplementedError();
  }

  void close() {
    if (this.closed) return;

    Message disconnectMsg = new Message(
      event: OnNamespaceDisconnect,
      isForced: true,
      isLocal: true,
    );

    this.connectedNamespaces.forEach((_, NsConn ns) {
      ns.forceLeaveAll(true);

      disconnectMsg.namespace = ns.namespace;

      fireEvent(ns, disconnectMsg);

      this.connectedNamespaces.remove(ns.namespace);
    });

    this.waitingMessages.clear();

    this.closed = true;

    this.sink?.close();
  }


  handle() {
    // TODO: implement handle
    throw UnimplementedError();
  }

  bool get isAcknowledged => this._isAcknowledged;

  bool get isClosed => this.closed;

  NsConn namespace(String namespace) {
    return this.connectedNamespaces[namespace];
  }

  Future<NsConn> waitServerConnect(String namespace) {
    // TODO: implement waitServerConnect
    throw UnimplementedError();
  }

  bool get wasReconnected => this.reconnectTries > 0;

  WebSocketSink get sink => this.channel?.sink;

  Stream get stream => this.channel?.stream;

  Conn({
    this.channel,
    this.namespaces,
  }) {
    _init();
  }

  _init() {
    this._isAcknowledged = false;
    this.reconnectTries = 0;
    this.queue = new List<String>();
    this.waitingMessages = new Map<String, waitingMessageFunc>();
    this.connectedNamespaces = new Map<String, NsConn>();
    this.closed = false;

    this.stream?.listen((data) => _onMessage(data),
        onError: _onError, onDone: _onDone);
  }

  bool write(Message msg) {
    if (msg.isConnect && !msg.isDisconnect) {
      NsConn ns = this.namespace(msg.namespace);

      if (ns == null) return false;

      if (msg.room == "" && !msg.isRoomJoin && !msg.isRoomLeft) {
        // if(!ns.rooms[msg.room])
      }
    }

    String data = serializeMessage(msg);
    return this._write(data);
  }

  void writeEmptyReply(String wait) {
    // TODO: implement writeEmptyReply
  }

  Future<void> _onMessage(msg) async {
    print("onMessage");
    print(msg);
  }

  Future<void> _onError(err) async {
    this.close();
  }

  Future<void> _onDone() async {
    if (!this.isClosed) {
      this.close();
    }
  }

  bool _write(dynamic data) {
    try {
      if (this.isClosed) return false;
      this.sink?.add(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}

SocketError fireEvent(NsConn ns, Message msg) {
  if (ns.events[msg.event] != null) {
    return ns.events[msg.event](ns, msg);
  }

  if (ns.events[OnAnyEvent] != null) {
    return ns.events[OnAnyEvent](ns, msg);
  }

  return null;
}

String serializeMessage(Message msg) {
  // TODO
  throw UnimplementedError();
}

String getWait() {
  Stopwatch s = new Stopwatch()..start();

  return waitComesFromClientPrefix + s.elapsedMicroseconds.toString();
}

Map<String, messageHandlerFunc> getEvents(
  Map<String, Map<String, messageHandlerFunc>> namespaces,
  String namespace,
) {
  return namespaces[namespace];
}
