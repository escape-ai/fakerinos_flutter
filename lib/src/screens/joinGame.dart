import 'package:flutter/material.dart';
import 'GameCommunication.dart';
import 'dart:convert' show json;
import 'dart:io';
import 'websockets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import './sharedPreferencesHelper.dart';



class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState(); 

}

class _JoinGameState extends State<JoinGame> {

  bool _isLoading = false; 
  WebSocketChannel channel;
  String username;
  String token; 

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text('TicTacToe'),
        ),
        body: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // _buildJoin(),
              new Text('Welcome join game?'),
              // _playersList(),
              joinGameButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget joinGameButton(){
    return new Container(
          padding: EdgeInsets.only(top: 20.0),
          child: _isLoading ? CircularProgressIndicator :
           ButtonTheme(
            key: Key('Join game'),
            minWidth: 350,
            height: 50,
            child: new RaisedButton(
            color: Colors.white,
            textColor: Color(0xAA0518FF),
            child: new Text("Join Game",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            onPressed: () async {
              setState(() {
                _isLoading = true; 
                            });
              if (true) {
              registerInSocket();
              Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new WebSocketScreen()));
            } else {
              print("ERROR");
            }},
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
        );
  }
  void registerInSocket() async {

    username = await getUsername(); 
    print("USERNAME:::::");
    print(username);
    token = await getMobileToken();

    Map <String, String> headers = {
      "Authorization": 
    "Token $token"
    };
    //  channel = IOWebSocketChannel.connect('ws://localhost:8000/wds/chat/lobby/'); 
    channel = IOWebSocketChannel.connect('wss://fakerinos-staging.herokuapp.com/ws/rooms/',
              headers: headers
      );
     var payload = {
       "action": "admin",
       "message": "request_to_join" 
     };
     channel.sink.add(json.encode(payload));
    //  add a server acknowledge
    
     

  }
}
