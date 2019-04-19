import 'package:flutter/material.dart'; 
import '../screens/register_screen.dart';
import '../screens/login_screen.dart';

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
        child: new ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200.0),
            child: Center(
              child: Text("FAKERINOS!", 
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontFamily: 'Niagaraphobia')
              )
            )
        ),
        Container(
            
            padding: EdgeInsets.only(top: 200.0),
            child: Center(
              child: Text(
                
                "Think you can tell Fake from Real? \n Come put your skills to a test!", 
                key: Key("description"),
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
            key: Key('Sign up'),
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
            onPressed: () => Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new RegisterScreen())),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
        ),

        Container(
          padding: EdgeInsets.only(top: 30),
          child: GestureDetector(
            onTap:(
              () => Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new LoginScreen()),
            
              )
            ),
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