import 'package:flutter/material.dart'; 
import '../screens/register_screen.dart';
import '../screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget { 

  

  @override
  Widget build(context){
    Size screenSize = MediaQuery.of(context).size;
    double screenUnitHeight = screenSize.height/100; 
    double screenUnitWidth = screenSize.width/100; 
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
            padding: EdgeInsets.only(top: screenUnitHeight * 15, bottom: screenUnitHeight * 5),
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
      new Center(
        
        child: Container(
          // padding: EdgeInsets.only(top: screenUnitHeight * 5),
            width: screenUnitWidth * 55,
            height: screenUnitWidth * 54,
            decoration: new BoxDecoration(
              
                // shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new ExactAssetImage(
                        "assets/logo.png")
                )),
      ),
      ),

        Container(
            padding: EdgeInsets.only(top: screenUnitHeight * 10),
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
          padding: EdgeInsets.only(top: screenUnitHeight * 3),
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