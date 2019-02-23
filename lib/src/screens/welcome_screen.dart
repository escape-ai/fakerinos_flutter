import 'package:flutter/material.dart'; 

class WelcomeScreen extends StatefulWidget {
  createState() { 
    return WelcomeStateScreen(); 
  } 
}

class WelcomeStateScreen extends State<WelcomeScreen> {

  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Getting Started")
        ),
        body: InterestGrid().build()
      )
    );
} }

class InterestGrid {
  Card makeGridCell(String name, IconData icon){
    return Card(
      elevation: 5.0, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down, 
        children: <Widget>[
          Center(child: Icon(icon)),
          Text(name), 
        ]
      ),
    );
  }
  
  GridView build(){
    return GridView.count(
      primary: true, 
      padding: EdgeInsets.all(2.0), 
      crossAxisCount: 2, 
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        makeGridCell("Home", Icons.home),
        makeGridCell("Email", Icons.email),
        makeGridCell("Chat", Icons.chat_bubble),
        makeGridCell("New", Icons.new_releases),
        makeGridCell("Wifi", Icons.network_wifi),
        makeGridCell("Options", Icons.settings),
        makeGridCell("Home", Icons.home),
        makeGridCell("Email", Icons.email),
        makeGridCell("Chat", Icons.chat_bubble),
        makeGridCell("New", Icons.new_releases),
        makeGridCell("Wifi", Icons.network_wifi),
        makeGridCell("Options", Icons.settings)
      ]
    );
  }
}