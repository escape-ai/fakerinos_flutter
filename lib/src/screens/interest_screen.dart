import 'package:flutter/material.dart'; 
import '../screens/home_screen.dart';
import "../Session.dart";

class InterestScreen extends StatefulWidget {

  Session session; 

  InterestScreen({@required this.session}); 
  createState() { 
    return InterestStateScreen(); 
  } 
}

class InterestStateScreen extends State<InterestScreen> {

  final List<String> _suggestions = <String>[]; 
  final Set<String> _saved = new Set<String>(); 

  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Getting Started")
        ),
        body: buildGrid(),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 2.0,
          onPressed: (){
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new HomeScreen()),
            );
          },
          icon: Icon(Icons.save),
          label: Text("Save")
        ),
      )
    );
} 
GestureDetector makeGridCell(String name, IconData icon){
    bool alreadySaved = _saved.contains(name);
    return GestureDetector(
      onTap: () => {
        setState((){
        if (alreadySaved) {
          _saved.remove(name);
        } else {
          _saved.add(name);
        } 
        print(_saved);
        })},
        
      child: Card(
      color: alreadySaved ? Colors.lightBlueAccent : Colors.white,
      elevation: 5.0, 
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, 
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.down, 
      children: <Widget>[
        Center(child: Icon(icon)),
        Center(child: Text(name)), 
        Center(child: Icon(Icons.favorite))
      ]
    )
      
    ));
  }
  
  GridView buildGrid(){
    return GridView.count(
      primary: true, 
      padding: EdgeInsets.all(2.0), 
      crossAxisCount: 2, 
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        makeGridCell("Adventures", Icons.terrain),
        makeGridCell("Local", Icons.local_activity),
        makeGridCell("Social", Icons.chat_bubble),
        makeGridCell("Sports", Icons.explore),
        makeGridCell("Adventures", Icons.terrain),
        makeGridCell("Local", Icons.local_activity),
        makeGridCell("Social", Icons.chat_bubble),
        makeGridCell("Sports", Icons.explore),
        makeGridCell("Adventures", Icons.terrain),
        makeGridCell("Local", Icons.local_activity),
        makeGridCell("Social", Icons.chat_bubble),
        makeGridCell("Sports", Icons.explore),
        
      ]
    );

} }