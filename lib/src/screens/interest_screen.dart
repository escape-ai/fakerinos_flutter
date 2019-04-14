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
  bool _isLoading = false; 
  final List<String> _suggestions = <String>[]; 
  final Set<String> _savedInterests = new Set<String>(); 
  final String url = "https://fakerinos.herokuapp.com/api/accounts/profile/";
   String username = "lionell26";
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
        body: (interestCardsData == null || _isLoading) ? 
        CircularProgressIndicator() :
        buildGrid(),
        floatingActionButton: _savedInterests.length == 0 ? 
        skipFAB() : selectedFAB()
      )
    );
} 

 Widget skipFAB(){
    return new FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          elevation: 2.0,
          onPressed: (){
            setState(() {
              _isLoading = true;
                        });
            uploadInterests();
            
          },
          label: Text("Skip"),
          icon: Icon(Icons.skip_next),
          
        );
  }

  Widget selectedFAB(){
    return new FloatingActionButton.extended(
          backgroundColor: Colors.greenAccent,
          elevation: 2.0,
          onPressed: (){
            setState(() {
              _isLoading = true;
                        });
                        
            uploadInterests();
            
          },
          
          label: Text(
            "Next " + _savedInterests.length.toString(),
              style: TextStyle(color: Colors.black)
          ),
          icon: Icon(Icons.send),
        );
  }


GestureDetector makeGridCell(String name, IconData icon){
    bool alreadySaved = _savedInterests.contains(name);
    return GestureDetector(
      onTap: () => {
        setState((){
        if (alreadySaved) {
          _savedInterests.remove(name);
        } else {
          _savedInterests.add(name);
        } 
        print(_savedInterests);
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

} 
  void uploadInterests() async {
    
    print("Uploading Interests to server..."); 

    Map<String, List<String>> payload = {
      "interests" : _savedInterests.toList()
    };
    var body = json.encode(payload); 
    print(body);
    print("lala");
    print(url + username + "/");
    final response = await patch(url + username + "/", body:body, 
    headers: {HttpHeaders.authorizationHeader: 
    "Token 3ade3638c37c5370ab3c0679a7a8107eee133ed7", 
    HttpHeaders.contentTypeHeader: "application/json"},
              ); 

    final parsedResponse = json.decode(response.body); 
    print(parsedResponse);

      if (parsedResponse != null){
      setState(() {
          // _isLoading = false;               
            });

      Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new HomeScreen()),
            );
  } 

 

  


} } 