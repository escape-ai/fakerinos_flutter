import 'package:flutter/material.dart'; 
import 'screens/register_screen.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: "Log Me In!",
      home: Scaffold(
        appBar: AppBar(title: Text("Registration")),
        body: RegisterScreen(),
      ));
  }
}