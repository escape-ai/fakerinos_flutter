import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import '../mixins/validation_mixin.dart';
import '../screens/interest_screen.dart';
import 'dart:convert';
import '../Session.dart';
import 'package:requests/requests.dart';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  
  final formKey = GlobalKey<FormState>();
  final String url = "https://fakerinos-staging.herokuapp.com/api/accounts/login/";
  String email = '';
  String username = '';
  String password = ''; 
  var _isLoading = false; 

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
        print(value);
      },
    );
  }

  Widget usernameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Type your username',
      ),
      onSaved: (String value) {
        username = value;
        print(value);
      },
    );
  }


  Widget submitButton() {
    return _isLoading == false? 
      RaisedButton (
        child:  Text('Log in'),
              
        onPressed: (() {
                
                if (formKey.currentState.validate()) {
                    _isLoading = true; 
                    formKey.currentState.save();
                    login();
            
             }})) : 
             RaisedButton(
               child: Center(
                 child: CircularProgressIndicator()
               )
             );
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

  void login() async {
    
    print("Verifying login credentials with server");
    Map<String, String> payload = {
      "username": username,
      "password": password,
    };
    final response = await new Session().post(url, payload);
    // final parsedResponse = json.decode(response["body"]); 
    print(response);
    if (response["key"] != null){
      _isLoading = false; 
      Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new InterestScreen()),
            );
    }else{
      
      String failureMessage = "Error: ";
      for (var value in response["non_field_errors"]){
        
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
          _isLoading = false; 
          Scaffold.of(context).showSnackBar(snackBar);
      print("No Success");
    }
    
  }
}
