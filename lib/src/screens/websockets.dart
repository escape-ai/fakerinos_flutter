import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';
import './sharedPreferencesHelper.dart';

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
  String username; 
  String token;

  // void getSharedPreferences() async {
  //   token = await getMobileToken(); 
  // }
  @override
  void initState() {
    super.initState();

    // connect();
    controller = TextEditingController();
    
  }

  void connect() async{ 
    print("connecting to websocket");
    token = await getMobileToken();
    // channel = IOWebSocketChannel.connect('ws://brave-zebra-6.localtunnel.me/ws/rooms/',
    //           headers: {HttpHeaders.authorizationHeader: "Token f5df1e5148f62f606792c0e6f5a288f0e34184ed" }
    //   );

    channel = IOWebSocketChannel.connect('ws://fakerinos.herokuapp.com/ws/rooms/',
              headers: {HttpHeaders.authorizationHeader: "Token $token" }
      );

    var payload = {
       "action": "admin",
       "message": "request_to_join" 
     };


    channel.sink.add(json.encode(payload));

    var payload2 = {
      "action": "response",
      "message" : {"response" : 1}
    };

    channel.stream.listen((data) => setState(() {
      String message = json.decode(data)["message"];
      print(message);
      list.add(message);
    }));
  }


  void leave() async{
      var payload = {
       "action": "admin",
       "message": "leave" 
     };

    channel.sink.add(json.encode(payload));
     
    }


  void sendData() {
    print("sending");
    if (controller.text.isNotEmpty) {
      // payload = {
      //   "message" : controller.text
      // };
      // var payload = {'message': '{"type":"send_everyone","message":"helloyoyo"}'};
     var payload2 = {
      "action": "response",
      "message" : {"response" : 1}
    };
     
     channel.sink.add(json.encode(payload2));
    
      
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
            ), 

          
            Row(
              children: <Widget>[
                button("connect", connect),
                button("leave", leave)
              ],
            )
           
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

  Widget button(String text, Function callback) {
    return new RaisedButton(
      child: Text(text),
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      splashColor: Colors.blueGrey,
      onPressed: () {
        callback();
    // Perform some action
  },
);
  }
}