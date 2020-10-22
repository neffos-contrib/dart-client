import 'conn.dart';
import 'event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'web_socket_channel_stub.dart'
if (dart.library.html) 'web_socket_channel_html.dart'
if (dart.library.io) 'web_socket_channel_io.dart';

Future<Conn> dial(String url,
    {Map<String, Map<String, messageHandlerFunc>> connHandler,
      connHeader}) async {
  WebSocketChannel channel = connectWebSocket(url);

  channel?.sink?.add(ackBinary);

  return new Conn(channel: channel, namespaces: connHandler);
}