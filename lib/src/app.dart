import 'package:flutter/material.dart'; 
import 'screens/welcome_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Log Me In!",
      home: Scaffold(
        // appBar: AppBar(title: Text("Registration")),
        body: WelcomeScreen(),
      ));
  }
}