import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';
import '../sharedPreferencesHelper.dart';
import 'dart:convert';
import 'dart:async';
import '../../SwipeAnimation/multiplayer_game.dart';
import '../webSocketHelper.dart';
import '../GameCommunication.dart';

class SearchOpponent extends StatefulWidget{
  createState() {
    return SearchOpponentState();
  }
}

class SearchOpponentState extends State<SearchOpponent> {

  
  bool _isConnected = false;
  bool _opponentFound = false;
  String username; 
  String token; 
  String status; 
  Map cardJson;
  // var requestToJoin = {"action": "admin", "message": "request_to_join"};

  void initState() {
    super.initState();
    print("Initializing search opponent");
    game.addListener(preGameListener);
    // game.addListener(checkOpponent);
    // connect();
  }
  
  void preGameListener(data){
    print("Callback: checkConnection called");
    print(data);
      if (data["message"]== "Connection success"){
        setState(() {
                  _isConnected = true;
                  status = data["message"];
                });

        game.send("admin", "request_to_join");
      }

      else if (data["action"]== "opponent"){
        setState(() {
                  _opponentFound = true;
                  status = data["message"];
                });
        game.send("admin", "request_to_join");
      }

      else if (data["action"] == "card"){
        String card = data["message"];
        cardJson = json.decode(card);
      }
  }

  
  @override 
  void dispose() {
      // TODO: implement dispose
      print("DISPOSE");
      game.quit();
      super.dispose();
    }

  void interpretMessage(json){

    switch(json["action"]){
      case("admin"): {
        switch(json["message"]){

          case("Connection success"): {
            setState(() {
              _isConnected = true;
              status = "Connected, requesting to join game"; 
                        });

            // join();
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

            !_opponentFound? new Container(): 
            new RaisedButton(
              child: Text('Start Game'), 

              onPressed: ((){
                print("pressed");
                
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