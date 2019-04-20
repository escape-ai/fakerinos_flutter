import "package:flutter/material.dart";
import "./searchOpponent.dart"; 

// import "../loading page/main.dart"

class MultiplayerScreen extends StatefulWidget{
  @override
  createState(){
    return MultiplayerScreenState(); 
  }
}

class MultiplayerScreenState extends State<MultiplayerScreen>{

   @override
  Widget build(context){
    Size screenSize = MediaQuery.of(context).size;
    double screenUnitHeight = screenSize.height/100; 
    double screenUnitWidth = screenSize.width/100; 

    return new Container(
    
        child: new Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: screenUnitHeight * 10, bottom: screenUnitHeight * 5),
            child: Center(
              child: Text("Multiplayer Mode!", 
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 60,
                  fontFamily: 'Niagaraphobia')
              )
            )
        ),
        Container(
          // padding: EdgeInsets.only(top: screenUnitHeight * 5),
            width: screenUnitWidth * 55,
            height: screenUnitWidth * 54,
            decoration: new BoxDecoration(
              shape:BoxShape.circle,
              
                // shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new ExactAssetImage(
                        "assets/multiplayer.gif")
                )),
      ),
        Container(
            padding: EdgeInsets.only(top: screenUnitHeight * 5),
            child: Center(
              child: Text("Challenge Others in a real time \n fake news prediction battle!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontFamily: "Roboto"
                )
              ))
            ),
        

        Container(
          padding: EdgeInsets.only(top: screenUnitHeight * 5),
          child: ButtonTheme(
            minWidth: 300,
            height: 50,
            child: new RaisedButton(
            onPressed: (){
              Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new SearchOpponent()));
            },
            color: Colors.blue,
            child: new Text("Play Now!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
        )]) );}}