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
import "../partials/cards.dart";

class SearchOpponent extends StatefulWidget{
  createState() {
    return SearchOpponentState();
  }
}

class SearchOpponentState extends State<SearchOpponent> {

  Cards cards;
  
  bool _isConnected = false;
  bool _opponentFound = false;
  String username; 
  String token; 
  String status = "Connecting to server... please wait."; 
  String opponentName;
  Map cardJson;
  double screenUnitHeight;
  double screenUnitWidth;
  // var requestToJoin = {"action": "admin", "message": "request_to_join"};

  void initState() {
    super.initState();
    print("Initializing search opponent");
    game.addListener(preGameListener);
    
  }
  
  void preGameListener(data){
    // print("Callback: checkConnection called");
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
                  opponentName = data["message"];
                  status = "Found opponent!";
                });
        game.send("admin", "request_to_join");
      }

      else if (data["pk"] != null){
        print("[SearchOpponent] found a card"); 
        cards = Cards.fromJson([data]);
      
      }

  }

  
  @override 
  void dispose() {
      // TODO: implement dispose
      print("Disposing [searchOpponent]");
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

  Widget startGameButton(){
    return new Container(
          padding: EdgeInsets.only(top: screenUnitHeight * 3),
          child: ButtonTheme(
            key: Key('Start Game'),
            minWidth: screenUnitWidth * 50,
            height: 50,
            child: new RaisedButton(
            color: Colors.white,
            textColor: Color(0xAA0518FF),
            child: new Text("Start Game",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            onPressed: () {
            print("Starting game");
            Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new MultiplayerGame(cards: cards)));
              },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
    );
  }

  Widget endConnectionButton(){
    return new Container(
          padding: EdgeInsets.only(top: screenUnitHeight * 3),
          child: ButtonTheme(
            key: Key('Quit'),
            minWidth: screenUnitWidth * 50,
            height: 50,
            child: new RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            child: new Text("Quit Waiting",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            onPressed: () {
            print("Quitting game");
            game.quit();
            
          
              },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
    );
  }



  Widget opponentInfo(String opponentUsername){

    return new Padding(
          padding: EdgeInsets.only(left: 3, right: 3),
          child: Container(
        
        width: 200,
        height: 60,
        child: Center(
          child: Padding( 
          padding: EdgeInsets.only(top: 6),
          child: Column(children: <Widget>[
            Text(opponentUsername,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
            
          ),),
          Text("Novice Player",
          style: TextStyle(
            fontSize: 18,
            
          ),)
            
          ],))
          ),
        decoration: BoxDecoration(
          color: Colors.yellow[600],
          borderRadius: BorderRadius.circular(30.0),
          // border: Border.all(
          //   color: Colors.black,
          //   width: 1.0,
          // ),
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    screenUnitHeight = screenSize.height/100; 
    screenUnitWidth = screenSize.width/100; 

    return Scaffold(
   backgroundColor: Colors.blue[400],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[400],
        title: Text("Multiplayer Game Set Up", style: TextStyle(fontSize: 24.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _isConnected ? (_opponentFound? 
                // new Container(
                //   height: 200,
                //   padding: EdgeInsets.only(top: 70, bottom: 70),
                //   child: opponentInfo(opponentName)):
                opponentInfo(opponentName):
                SpinKitRipple(color: Colors.white,size:200.0,
                duration: Duration(milliseconds: 3000))) 
                :
                SpinKitDoubleBounce(color: Colors.white, size: 200.0, 
                duration: Duration(milliseconds: 3500)),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Status: $status", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
              
              ],
            ),
            const SizedBox(height: 30.0),
               const SizedBox(height: 10.0),
            !_opponentFound? new Container(): 
            startGameButton(),
            endConnectionButton()
          ],
        ),
      ),
    );
  }
}