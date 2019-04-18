import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../mixins/validation_mixin.dart';
import '../screens/interest_screen.dart';
import './onboarding_screen.dart';
import 'dart:convert';
import '../Session.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/src/material/dropdown.dart'; 
import './camera_screen.dart';
import './sharedPreferencesHelper.dart';


class ParticularsScreen extends StatefulWidget {
  createState() {
    return ParticularsScreenState();
  }
}

class ParticularsScreenState extends State<ParticularsScreen> with ValidationMixin {
  
  final session = new Session(); 
  final formKey = GlobalKey<FormState>();
  final String url = "https://fakerinos.herokuapp.com/api/accounts/profile/";
  // Hardcode the username first 
  String username; 
  String firstName;
  String lastName;
  String selectedEducationLevel; 
  String dobString = ""; 
  String dobErrorString = ""; 
  String educationErrorString = "";
  String token; 

  List educationLevels = ["Select", "Primary", "Secondary", "Junior College", "Polytechnic", "ITE", "Others"];
  List<DropdownMenuItem<String>> dropDownEducationLevels;

  var _isLoading = false; 

  @override
  void initState() {
    dropDownEducationLevels = buildAndGetDropDownMenuItems(educationLevels);
    selectedEducationLevel = dropDownEducationLevels[0].value;
    
    super.initState();
  }

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
          expandableDatePicker(),
          dobText(),
          dobErrorText(),
          Container(margin: EdgeInsets.only(top: 50.0)),
          selectEducationField(),
          educationErrorText(),
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
      validator: validateFirstName,
      onSaved: (String value) {
        firstName = value;
        
      },
    );
  }

  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'e.g. Loh',
      ),
      validator: validateLastName,
      onSaved: (String value) {
        lastName = value;
        
      },
    );
  }


   List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List educationLevels) {
    List<DropdownMenuItem<String>> items = new List();
    for (String educationLevel in educationLevels) {
      items.add(new DropdownMenuItem(value: educationLevel, child: new Text(educationLevel)));
    }
    return items;
  }

  void changedDropDownItem(String selectedChoice) {
    setState(() {
      selectedEducationLevel = selectedChoice;
    });
  }


  Widget selectEducationField(){
    return new DropdownButton(
              value: selectedEducationLevel,
              items: dropDownEducationLevels,
              onChanged: changedDropDownItem,
            );
    }
  
  Widget expandableDatePicker() {
    return new FlatButton(
    onPressed: () {
        DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1950, 1, 1),
                              maxTime: DateTime(2009, 1, 1), 
                              onChanged: (date) {},
                              onConfirm: (date) {      
                              setState((){
                              dobString = date.toString().split(" ")[0];
                              
                            });
                                
                          }, currentTime: DateTime(2009, 1, 1), locale: LocaleType.en);
    },
    child: Text(
        'Select your birthday',
        style: TextStyle(color: Colors.blue),
    ));
  }

  Widget dobText(){
    return Text(dobString,
    style: TextStyle(color: Colors.black, fontSize: 20)); 
  }

  Widget dobErrorText(){

    return Text(dobErrorString,
    style: TextStyle(color: Colors.red, fontSize: 12)); 
  }

  Widget educationErrorText(){

    return Text(educationErrorString,
    style: TextStyle(color: Colors.red, fontSize: 12)); 
  }

 
  Widget submitButton() {
    return _isLoading == true? 
      CircularProgressIndicator():
      RaisedButton (
        child:  Text('Next'),
              
        onPressed: () {
                
                if (formKey.currentState.validate() && dobString != "" && selectedEducationLevel != "Select") {
                    setState(() {
                  formKey.currentState.save();
                  educationErrorString = "";
                  dobErrorString = "";

                  _isLoading = true;  
                  uploadParticulars();              
                                });
             } else {
                print("unvalidated!");
                if (dobString == "") {
                  setState((){
                    dobErrorString = "Please enter your date of birth";
                  });
                } else {
                  setState((){
                    dobErrorString = "";
                  });
                }

                 if (selectedEducationLevel == "Select") {
                  setState((){
                    educationErrorString = "Please select your current education level";
                  });
                } else {
                  setState((){
                    educationErrorString = "";
                  });
                }

             } });}
             
            
            


  Widget welcomePageButton() {
    return RaisedButton(
        child: Text("Welcome Page"),
        color: Colors.blueGrey,
        onPressed: () {
          
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new ParticularsScreen()),
            );
        
        });
  }

  
  void uploadParticulars() async { 

      print("Uploading particulars to server..."); 
      Map<String, String> payload = {
        "first_name" : firstName, 
        "last_name" : lastName,
        "birth_date": dobString, 
        "education": selectedEducationLevel,

      };
      token = await getMobileToken();
      username = await getUsername(); 
      Map<String, String> headers = {
        "Authorization": "Token $token"
      };
      
      final response = await patch(url + username + "/", body:payload, headers: headers); 
      print(response.body);
      final parsedResponse = json.decode(response.body); 
      print(parsedResponse);

      if (response.statusCode == 200){
      setState(() {
          _isLoading = false;               
            });
      
       Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new InterestScreen()),
            );

      setFirstName(firstName);
      setLastName(lastName);
      
  }   else {
        setState(() {
                  _isLoading = false;               
                                });
      String failureMessage = parsedResponse;
      
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
      

  } }

  }
