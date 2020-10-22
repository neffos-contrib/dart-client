library neffos;

/// https://github.com/dart-lang/language/issues/65
/// https://github.com/dart-lang/web_socket_channel/issues/69
/// typedef events = Map<string, MessageHandlerFunc>;
/// typedef namespaces = Map<string, Events>;

export 'src/conn.dart';
export 'src/event.dart';
export 'src/room.dart';
export 'src/message.dart';
export 'src/ns_conn.dart';
export 'src/neffos.dart';