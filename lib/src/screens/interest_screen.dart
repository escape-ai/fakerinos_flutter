import 'package:flutter/material.dart'; 
import 'dart:convert';
import '../screens/home_screen.dart';
import "../Session.dart";
import 'package:http/http.dart'; 
import 'partials/InterestCards.dart';
import 'dart:io';


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
  InterestCards interestCardsData; 

  @override
  void initState(){
    super.initState();
    print("Interest Screen Initializing");
    _fetchData(); 
  }

  _fetchData() async {
      print("Fetching data"); 
      
    final response = await get("https://fakerinos.herokuapp.com/api/articles/tag",
    headers: {HttpHeaders.authorizationHeader: "Token 3ade3638c37c5370ab3c0679a7a8107eee133ed7"}); 
    print(response.body); 
    if (response.statusCode == 200) {
      var decodedJson = new List();
      
      decodedJson = jsonDecode(response.body); 
      // print(decodedJson);
      interestCardsData = InterestCards.fromJson(decodedJson);

      print("Interest Cards data output");
      print(interestCardsData.toJson()); 

      setState(() {
      });
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load cards');
    }
  }

  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tell us what interest you!")
        ),
        body: interestCardsData == null ? 
        CircularProgressIndicator() :
        buildGrid(),
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
      children: interestCardsData.interestCards.map(
        (card) => makeGridCell(card.name, Icons.trending_up)).toList()
    );

} }