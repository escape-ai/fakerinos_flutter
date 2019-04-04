import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import '../mixins/validation_mixin.dart';
import '../screens/interest_screen.dart';
import 'dart:convert';
import '../Session.dart';

class ParticularsScreen extends StatefulWidget {
  createState() {
    return ParticularsScreenState();
  }
}

class ParticularsScreenState extends State<ParticularsScreen> with ValidationMixin {
  
  final session = new Session(); 
  final formKey = GlobalKey<FormState>();
  final String url = "https://fakerinos.herokuapp.com/api/accounts/login/";
  String firstName = '';
  String lastName = '';
  String education = ''; 
  String dob = ''; 
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
          firstNameField(),
          lastNameField(),
          Container(margin: EdgeInsets.only(top: 100.0)),
          submitButton(),
          
        ]),
      ),
    )
    );
    
  }

  Widget firstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'e.g. Lionell',
      ),
      //TODO: add validator
      validator: null,
      onSaved: (String value) {
        firstName = value;
        print(value);
      },
    );
  }

  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'e.g. Loh',
      ),
      //TODO: add validator
      validator: null,
      onSaved: (String value) {
        lastName = value;
        print(value);
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

    final response = await session.post(url, payload);
    // final parsedResponse = json.decode(response["body"]); 
    print(response);
    if (response["key"] != null){
      setState(() {
          _isLoading = false;               
            });
      Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new InterestScreen(session: session)),
            );
    }else{
      setState(() {
                  _isLoading = false;               
                                });
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
          setState(() {
                  _isLoading = false;               
                                });
          Scaffold.of(context).showSnackBar(snackBar);
      print("No Success");
    }
    
  }
}
