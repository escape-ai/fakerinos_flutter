import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../mixins/validation_mixin.dart';
import '../screens/interest_screen.dart';
import 'dart:convert';
import 'dart:io';
import './particulars_screen.dart';
import './sharedPreferencesHelper.dart';
import './onboarding_screen.dart';
import "./partials/default.dart";
import '../screens/home_screen.dart';



class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  
  final formKey = GlobalKey<FormState>();
  final String url = "https://fakerinos.herokuapp.com/api/accounts/login/";
  String email = '';
  String username = '';
  String password = ''; 
  String firstName;
  String lastName; 
  String token; 
  var _isLoading = false; 
  bool _isOnboarded;

  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(children: [
          Container(margin: EdgeInsets.only(top: 240.0)),
          usernameField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 100.0)),
          submitButton(),
          
        ]),
      ),
    )
    );
    
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password = value;
        
      },
    );
  }

  Widget usernameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Type your username',
      ),
      validator: validateUsername,
      onSaved: (String value) {
        username = value;
        
      },
    );
  }


  Widget submitButton() {
    return _isLoading == true? 
      CircularProgressIndicator():
      RaisedButton (
        child:  Text('Log in'),
              
        onPressed: (() {
                
                if (formKey.currentState.validate()) {
                    setState(() {
                  _isLoading = true;               
                                });
                    formKey.currentState.save();
                    
                    login();
            
             }})); 
  }

  Widget welcomePageButton() {
    return RaisedButton(
        child: Text("Welcome Page"),
        color: Colors.blueGrey,
        onPressed: () {
          print("pressed");
          
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new OnboardingScreen()),
            );
        
        });
  }

  void login() async {
    
    print("Verifying login credentials with server");
    Map<String, String> payload = {
      "username": username,
      "password": password,
    };

    final response = await post(url, body:payload);
    final parsedResponse = json.decode(response.body); 
    print(parsedResponse);

    setUsername(username);
    
    //Success
    if (response.statusCode == 200){
      token = parsedResponse["key"];
      final userData = await get("https://fakerinos.herokuapp.com/api/accounts/profile/$username/", headers: {
        HttpHeaders.authorizationHeader: "Token $token"}); 
        var decodedUserData = json.decode(userData.body);
      _isOnboarded = decodedUserData["onboarded"];
      firstName = decodedUserData["first_name"];
      lastName = decodedUserData["last_name"];
      setFirstName(firstName);
      setLastName(lastName);
      
      print("Onboarded: $_isOnboarded");
      setMobileToken(token);
      setUsername(username);
      
      
      setState(() {
          _isLoading = false;               
            });
      Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => _isOnboarded? new HomeScreen(): new OnboardingScreen()),
            );
    }else{
      setState(() {
                  _isLoading = false;               
                                });
      String failureMessage = "Error: ";
      for (var value in parsedResponse["non_field_errors"]){
        
        failureMessage += value[0] + " "; 
        
      }
      print(failureMessage);
      final snackBar = SnackBar(
            content: Text("$failureMessage"),
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
                                });
          Scaffold.of(context).showSnackBar(snackBar);
      print("No Success");
    }

    
    
  }
}
