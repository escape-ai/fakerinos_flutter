import 'package:flutter/material.dart'; 
import 'dart:convert';
import '../screens/home_screen.dart';
import "../Session.dart";
import 'package:http/http.dart'; 
import 'partials/InterestCards.dart';
import 'dart:io';
import './sharedPreferencesHelper.dart';




class InterestScreen extends StatefulWidget {

  Session session; 

  InterestScreen({@required this.session}); 
  createState() { 
    return InterestStateScreen(); 
  } 
}

class InterestStateScreen extends State<InterestScreen> {
  bool _isLoading = false; 
  String token; 
  final List<String> _suggestions = <String>[]; 
  final Set<String> _savedInterests = new Set<String>(); 
  final String url = "https://fakerinos.herokuapp.com/api/accounts/profile/";
  InterestCards interestCardsData; 
  String username; 

 

  @override
  void initState(){
    super.initState();
    print("Interest Screen Initializing");
    _fetchData(); 
  }

  _fetchData() async {

    token = await getMobileToken();
    print("Fetching data"); 
    print("token");
    print(token);
    final response = await get("https://fakerinos.herokuapp.com/api/articles/tag",
    headers: {HttpHeaders.authorizationHeader: "Token $token" }); 
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
          key : Key("skipInterest"),
          
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
          key : Key("nextInterest"),
          
          label: Text(
            "Next " + _savedInterests.length.toString(),
              style: TextStyle(color: Colors.black)
          ),
          icon: Icon(Icons.send),
        );
  }


GestureDetector makeGridCell(String name, String thumbnailUrl){
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
       
      key : Key("TAP${name}"), //Yunyi

      child: Card(
      color: alreadySaved ? Colors.lightBlueAccent : Colors.white,
      
      elevation: alreadySaved? 30.0: 5.0, 
      child: new Container(
        child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(
                const  Radius.circular(5.0),
                   ),
        color: alreadySaved? Color(0xAA03B2FF).withOpacity(0.7) : Colors.black.withOpacity(0.2),
     ),
                  child: new Center(
                    child: Text(name, 
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Niagaraphobia')))

                )
              ,
        decoration: new BoxDecoration(
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                colorFilter: alreadySaved? ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop):
                ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.cover,
                
                // colorFilter: new ColorFilter.mode(Color(0xAA0518FF).withOpacity(0.6), BlendMode.softLight),
                image: new NetworkImage(
                  thumbnailUrl
                )
      ),
      // child: Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch, 
      // mainAxisSize: MainAxisSize.min,
      // verticalDirection: VerticalDirection.down, 
      // children: <Widget>[
      //   Center(child: Icon(icon)),
      //   Center(child: Text(name)), 
      //   Center(child: Icon(Icons.favorite))
      // ]
    )
      
    )));
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
        (card) => makeGridCell(card.name, card.thumbnail_url)).toList()
    );

} 
  void uploadInterests() async {
    
    print("Uploading Interests to server..."); 
  
    username = await getUsername();
    print("Getting username...");
    print("username: " + username);
    Map<String, dynamic> payload = {
      "interests" : _savedInterests.toList(),
      "onboarded": "true",
      "is_complete" : _savedInterests.length > 0 ? "true" : "false"
    };
    var body = json.encode(payload); 
    print(body);
    
    print(url + username + "/");
    final response = await patch(url + username + "/", body:body, 
    headers: {HttpHeaders.authorizationHeader: 
    "Token $token", 
    HttpHeaders.contentTypeHeader: "application/json"},
              ); 
  
    final parsedResponse = json.decode(response.body); 
    print(parsedResponse);
      print(response.statusCode);
      // Temp workaround to get to decks page
      if (response.statusCode != 123){
      setState(() {
          _isLoading = false;               
            });

      Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new HomeScreen()),
            );
  } 

} } 