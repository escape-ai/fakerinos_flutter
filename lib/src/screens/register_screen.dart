import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import '../mixins/validation_mixin.dart';
import '../screens/interest_screen.dart';
import 'dart:convert';
import "./websockets.dart";
import './sharedPreferencesHelper.dart';
import './camera_screen.dart';
import './partials/searchOpponent.dart';
import './onboarding_screen.dart';

// This is the join game screen
import "./joinGame.dart"; 

class RegisterScreen extends StatefulWidget {
  createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String url = "https://fakerinos.herokuapp.com/api/accounts/register/";
  String email = '';
  String username = '';
  String password1 = '';
  String password2 = '';
  var _isLoading = false; 

  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: new Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(children: [
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/10 * 3)),
          usernameField(),
          emailField(),
          passwordField(),
          confirmPasswordField(),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/10 )),
          _isLoading ? CircularProgressIndicator() : submitButton(),
          // welcomePageButton(),
          // // socketButton(),
          // multiplayerGameButton(),
          // cameraButton()
          
        ]),
      ),
    )
    );
    
  }

  Widget usernameField() {
    return TextFormField(
      key : Key("username"),
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'e.g. johndoe96',
      ),
      
      validator: validateUsername,
      
      onSaved: (String value) {
        username = value;
        print(value);
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      key : Key("email"),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'fakerinos@gmail.com',
      ),
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
        print(value);
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      key : Key("password"),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password1 = value;
        print(value);
      },
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      key : Key("confirmed password"),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Enter your password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password2 = value;
        print(value);
      },
    );
  }

  Widget submitButton() {
    return new RaisedButton (
        key : Key("submit button"),
        child:  Text('Register'),
              
        onPressed: (() {
                
                if (formKey.currentState.validate()) {
                    setState(()=> _isLoading = true);
            
            formKey.currentState.save();
         
            Register();
            
             }}));
             
  }
  void Register() async {
    
    print("Registering with server side...");
    Map<String, String> payload = {
      "username": username,
      "email": email,
      "password1": password1,
      "password2": password2
    };
    final response = await post(url, body: payload);
    final parsedResponse = json.decode(response.body); 
   
   //Login Successful
    if (parsedResponse["key"] != null){

      setMobileToken(parsedResponse["key"]);
      setUsername(username);
      
      _isLoading = false; 
      Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new OnboardingScreen()),
            );
    }else{
      
      String failureMessage = "Error: ";
      for (var value in parsedResponse.values){
        
        failureMessage += value[0] + " "; 
      }
      print(failureMessage);
      var snackBar = SnackBar(
            content: 
            Text("$failureMessage",
            key: Key("snackbar")),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change!
              },
            ),
          );

          // Find the Scaffold in the Widget tree and use it to show a SnackBar!

          setState(() {
            _isLoading = false; 
            _scaffoldKey.currentState.showSnackBar(snackBar);    
                    });
          
      print("No Success");
    }
    
  }

  Widget welcomePageButton() {
    return RaisedButton(
        child: Text("Welcome Page"),
        color: Colors.blueGrey,
        onPressed: () {
          print("pressed");
          
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new InterestScreen()),
            );
        
        });
  }

  // Widget socketButton() {
  //   return RaisedButton(
  //       child: Text("SocketConnection"),
  //       color: Colors.blueGrey,
  //       onPressed: () {
  //         print("pressed");
          
  //           Navigator.push(
  //             context,
  //             new MaterialPageRoute(builder: (context) => new WebSocketScreen()),
  //           );
        
  //       }); }

  Widget multiplayerGameButton() {
    return RaisedButton(
        child: Text("MultiplayerGame"),
        color: Colors.blueGrey,
        onPressed: () {
          print("pressed");
          
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new SearchOpponent()),
            );
        
        });
  } 

  Widget cameraButton() {
    return RaisedButton(
        child: Text("camera"),
        color: Colors.blueGrey,
        onPressed: () {
          print("pressed");
          
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new TakePictureScreen()),
            );
        
        });
  } 


  
}
