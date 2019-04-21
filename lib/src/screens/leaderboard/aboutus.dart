import 'package:flutter/material.dart';



class ABOUTus extends StatefulWidget {
  

  createState(){
    return ABOUTusState(); 
  }
}

class ABOUTusState extends State<ABOUTus> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About Us"),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                   SizedBox(height: 20),
                  new Center(
      child: Container(
        width: 240.0,
        height: 240.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/about1.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(120.0),
          border: Border.all(
            color: Colors.blue[50],
            width: 10.0,
          ),
        ),
      ),
    ),
     SizedBox(height: 20),
    new Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        "Fake news is becoming increasingly prevalent as perpetrators.",
        style: TextStyle(
  
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
    SizedBox(height: 20),
    new Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        "In our card-swiping game,you will learn how to discern fakenews.",
        style: TextStyle(
  
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
    SizedBox(height: 20),
    new Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        "With training,you will be perceptive and able to combat fakenews.",
        style: TextStyle(
  
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
                  
                 
                  
                ],
              ))),
    );
  }
}