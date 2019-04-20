import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';
import '../sharedPreferencesHelper.dart';
import 'dart:convert';
import 'dart:async';
import '../../SwipeAnimation/multiplayer_game.dart';

class SearchOpponent extends StatefulWidget{
  createState() {
    return SearchOpponentState();
  }
}

class SearchOpponentState extends State<SearchOpponent> {

  WebSocketChannel channel;
  bool _isConnected = false;
  String username; 
  String token; 
  String status; 

  void initState() {
    super.initState();
    print("Initilizing state");
    
    connect();
    
  }

  void connect() async {
    print("connecting to websocket");
    token = await getMobileToken();

    channel = IOWebSocketChannel.connect('ws://fakerinos.herokuapp.com/ws/rooms/',
              headers: {HttpHeaders.authorizationHeader: "Token $token" }
      );
  
    channel.stream.listen((data) => setState(() {
      var decodedData = json.decode(data);
      print(decodedData);
      interpretMessage(decodedData);
      // String message = json.decode(data)["message"];
      // print(json.decode(data));
      
    }));
    
  }

  void join() async {
    print("Requesting to join the game");
    token = await getMobileToken();
    var payload = {
       "action": "admin",
       "message": "request_to_join" 
     };
    channel.sink.add(json.encode(payload));
  }

  void interpretMessage(json){

    switch(json["action"]){
      case("admin"): {
        print("Admin");
        switch(json["message"]){

          case("connection success"): {
            setState(() {
              _isConnected = true;
              status = "Connected, requesting to join game"; 
                        });

            join();
          }
          break;

          case("game ready"): {
            setState(() {
              print("GAME IS READY");
            });
          }
          break; 

          case("There is something wrong with your connection. Please try again"):{
              setState((){
                status = "Something wrong with connection";
              });
          }

          
        }
      }
    }
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.blue[400],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[400],
        title: Text("Dual Mode", style: TextStyle(fontSize: 24.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _isConnected ? 
                SpinKitRipple(color: Colors.white,size:200.0,
                duration: Duration(milliseconds: 3000)) :
                SpinKitCubeGrid(color: Colors.white, size: 200.0, 
                duration: Duration(milliseconds: 3000)),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Status: $status", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
              
              ],
            ),
            const SizedBox(height: 60.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Text("Click the upper-left cross to stop searching.", style: TextStyle(fontSize: 16.0),textAlign: TextAlign.center,),
                
              ],
            ),
            const SizedBox(height: 48.0),

            new RaisedButton(
              child: Text('Start Game'), 

              onPressed: ((){
                Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new MultiplayerGame()),
            );

              }),   

            )


          ],
        ),
      ),
    );
  }
}