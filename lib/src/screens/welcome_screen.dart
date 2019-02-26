import 'package:flutter/material.dart'; 

class WelcomeScreen extends StatelessWidget { 

  @override
  Widget build(context){
    return new Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter,
          stops: [0.25, 0.75],
          colors: [Color(0xAA03B2FF), Color(0xAA0518FF) ]
        )),
        child: new Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200.0),
            child: Center(
              child: Text("FAKERINOS!", style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontFamily: 'Niagaraphobia')
              )
            )
        ),
        Container(
            padding: EdgeInsets.only(top: 260.0),
            child: Center(
              child: Text("Think you can tell Fake from Real? \n Come put your skills to a test!", 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                )
              )
            )
        ),

        Container(
          padding: EdgeInsets.only(top: 70.0),
          child: ButtonTheme(
            minWidth: 350,
            height: 50,
            child: new RaisedButton(
            color: Colors.white,
            textColor: Color(0xAA0518FF),
            child: new Text("Sign Up",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            onPressed: ()=> print("pressed"),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
        ),

        Container(
          padding: EdgeInsets.only(top: 30),
          child: GestureDetector(
            child: Text("Log in",
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              color: Colors.white          
            ))
          )
        )
         
                        ])
        
    );
  }
}