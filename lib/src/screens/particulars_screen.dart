import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show post;
import '../mixins/validation_mixin.dart';
import '../screens/interest_screen.dart';
import 'dart:convert';
import '../Session.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/src/material/dropdown.dart'; 
import './camera_screen.dart';

class ParticularsScreen extends StatefulWidget {
  createState() {
    return ParticularsScreenState();
  }
}

class ParticularsScreenState extends State<ParticularsScreen> with ValidationMixin {
  
  final session = new Session(); 
  final formKey = GlobalKey<FormState>();
  final String url = "https://fakerinos.herokuapp.com/api/accounts/login/";
  String firstName;
  String lastName;
  String selectedEducationLevel; 
  String dobString = ""; 
  List educationLevels = ["Primary", "Secondary", "Junior College", "Polytechnic"];
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
          Container(margin: EdgeInsets.only(top: 50.0)),
          selectEducationField(),
          
          
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


   List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List educationLevels) {
    List<DropdownMenuItem<String>> items = new List();
    for (String educationLevel in educationLevels) {
      items.add(new DropdownMenuItem(value: educationLevel, child: new Text(educationLevel)));
    }
    return items;
  }

  void changedDropDownItem(String selectedEducationLevel) {
    setState(() {
      selectedEducationLevel = selectedEducationLevel;
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
        'show date time picker (English)',
        style: TextStyle(color: Colors.blue),
    ));
  }

  Widget dobText(){
    return Text(dobString,
    style: TextStyle(color: Colors.black, fontSize: 20)); 
  }

 


  Widget submitButton() {
    return _isLoading == true? 
      CircularProgressIndicator():
      RaisedButton (
        child:  Text('Next'),
              
        onPressed: (() {
                
            //     if (formKey.currentState.validate()) {
            //         setState(() {
            //       _isLoading = true;  
            //       formKey.currentState.save();
            //       submitParticulars();              
            //                     });
            //  }

            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new CameraApp()),
            );
            
             })); 
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

  
  void submitParticulars() async {


  }



  // void login() async {
    
  //   print("Verifying login credentials with server");
  //   Map<String, String> payload = {
  //     "firstName": firstName,
  //     "lastName": lastName,
  //   };

  //   final response = await post(url, body: payload);
  //   final parsedResponse = json.decode(response.body); 
  //   print(parsedResponse);
  //   if (parsedResponse.key != null){
  //     setState(() {
  //         _isLoading = false;               
  //           });
  //     Navigator.push(
  //             context,
  //             new MaterialPageRoute(builder: (context) => new InterestScreen(session: session)),
  //           );
  //   }else{
  //     setState(() {
  //                 _isLoading = false;               
  //                               });
  
        
  //     }
      
  //     final snackBar = SnackBar(
  //           content: Text("lalala"),
  //           action: SnackBarAction(
  //             label: 'Undo',
  //             onPressed: () {
  //               // Some code to undo the change!
  //             },
  //           ),
  //         );

  //         // Find the Scaffold in the Widget tree and use it to show a SnackBar!
  //         setState(() {
  //                 _isLoading = false;               
  //                               });
  //         Scaffold.of(context).showSnackBar(snackBar);
     
  //   }
    
  }
