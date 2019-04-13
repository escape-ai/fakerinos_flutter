import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }


class WebSocketScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebSocketScreen> {
  WebSocketChannel channel;
  TextEditingController controller;
  final List<String> list = [];
  Map<String, String> payload;

  @override
  void initState() {
    super.initState();
     Map <String, String> headers = {
      "Authorization": 
    "Token 3bb2b0eb58485d8b42e2457ac43eff650ce8e2d5"
    };
    channel = IOWebSocketChannel.connect('wss://fakerinos-staging.herokuapp.com/ws/rooms/1/',
              headers: headers
      );
    controller = TextEditingController();
    channel.stream.listen((data) => setState(() {
      String message = json.decode(data)["message"];
      print(message);
      list.add(message);
    }));
  }

  void sendData() {
    print("sending");
    if (controller.text.isNotEmpty) {
      // payload = {
      //   "message" : controller.text
      // };
      var payload = {'message': '{"type":"send_everyone","message":"helloyoyo"}'};
     channel.sink.add(json.encode(payload));
    
      
      controller.text = "";
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Example'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Send to WebSocket",
                ),
              ),
            ),
            Column(
              children: list.map((data) => Text(data)).toList(),
            )

            // StreamBuilder(
            //   stream: channel.stream,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     return Container(
            //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          sendData();
        },
      ),
    );
  }
}