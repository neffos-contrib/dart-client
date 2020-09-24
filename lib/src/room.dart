import 'ns_conn.dart';

class Room {
  String name;

  NsConn nsConn;

  bool emit() {
    // TODO: implement emit
    throw UnimplementedError();
  }

  Future<String> leave() {
    // TODO: implement leave
    throw UnimplementedError();
  }

  Room({this.name, this.nsConn});
}