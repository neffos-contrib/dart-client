import 'package:flutter/material.dart';
import 'package:neffos/neffos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [FlatButton(onPressed: () => conn(), child: Text("conn"))],
      ),
    );
  }

  conn() async {
    Conn conn = await dial("ws://127.0.0.1:9501/ws", connHandler: {
      "default": {
        OnNamespaceConnect: (NsConn ns, Message msg) {
          print(msg.body);
        }
      }
    });

    print(conn.id);

    NsConn nsConn = await conn.connect("default");
    print(nsConn.namespace);

    Room room = await nsConn.joinRoom("default");

    print(room.name);
  }
}
