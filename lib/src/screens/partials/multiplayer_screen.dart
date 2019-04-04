import "package:flutter/material.dart"; 

class MultiplayerScreen extends StatefulWidget{
  @override
  createState(){
    return MultiplayerScreenState(); 
  }
}

class MultiplayerScreenState extends State<MultiplayerScreen>{

   @override
  Widget build(context){
    return new Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter,
          stops: [0.25, 0.75],
          colors: [Colors.lightBlueAccent, Colors.blue ]
        )),
        child: new Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200.0),
            child: Center(
              child: Text("Multiplayer Mode!!", 
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontFamily: 'Niagaraphobia')
              )
            )
        ),
        Container(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(
              child: Text("Challenge Others in a real time \n fake news prediction battle!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                )
              ))
            ),
        

        Container(
          padding: EdgeInsets.only(top: 70.0),
          child: ButtonTheme(
            minWidth: 200,
            height: 50,
            child: new RaisedButton(
            color: Colors.white,
            textColor: Colors.white,
            child: new Text("Play Now!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
        )]) );}}