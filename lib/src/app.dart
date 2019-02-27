import 'package:flutter/material.dart'; 
import 'screens/register_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/loginscreen_3.dart';
import 'screens/welcome_screen.dart';

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