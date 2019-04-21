import "package:flutter/material.dart"; 
import 'package:http/http.dart'; 
import 'dart:io';
import 'dart:convert';
import "../../SwipeAnimation/crowdSourceGame.dart";
import "./cards.dart";
import "../../Session.dart";
import "./decks.dart"; 
import "../leaderboard/leaderboardPage.dart";
import '../sharedPreferencesHelper.dart';


class CrowdSourceScreen extends StatefulWidget{
  @override
   

  createState(){
    return CrowdSourceState(); 
  }

  
}

class CrowdSourceState extends State<CrowdSourceScreen>{

  Decks decksData;
  Deck doubleTappedDeck;
  Deck tappedDeck; 
  final Set<int> starredDecks  = new Set<int>(); 
  String particularsUrl = "https://fakerinos.herokuapp.com/api/accounts/profile/";
  String username;
  String token; 
  bool contains = false; 
  
  
  Widget starIcon(){
    
    return new IconButton(
            // icon: contains ? Icon(Icons.star) : Icon(Icons.star_border),
            icon: Icon(Icons.star_border),
            color: Colors.yellow[800],
            onPressed: _toggleFavorite(0),
          );
  }

   _toggleFavorite(int itemIndex){
    setState(() {
        doubleTappedDeck = decksData.decks[itemIndex]; 
        // Adding or removing deck logic 
        starredDecks.contains(doubleTappedDeck.pk) ? 
        contains = true : contains = false; 
        contains ? starredDecks.remove(doubleTappedDeck.pk) : 
        starredDecks.add(doubleTappedDeck.pk);

        print(starredDecks);
        starDecks();
        });
  }

  @override
  void initState(){
    super.initState();
    print("Default Home Screen w Decks initializing");
    
    _fetchData(); 
  }

    _fetchData() async {
      
      print("Fetching data"); 
      token = await getMobileToken(); 
      username = await getUsername();
    final response = await get("https://fakerinos.herokuapp.com/api/articles/deck/poll", 
    headers: {HttpHeaders.authorizationHeader: "Token $token"}); 
    
    if (response.statusCode == 200) {
            
      var decodedJson = jsonDecode(response.body); 
      print(decodedJson);
      

      setState(() {
        decksData = Decks.fromJson(decodedJson);
      });
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load cards');
    }
  }
  @override
  Widget build(BuildContext context){
    // Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Center (
        child: new Container(
        width: 500,
        height: 1000,
        child: Column(children: <Widget>[
        Expanded(
        child: decksData == null ?
        Center(child: CircularProgressIndicator(),
        ) : 
        ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if(index <= 0 ) {
            return _buildCarousel(context, index ~/ 2);
          }
          else {
            return Divider(
              height: 3
            );
          }
        },
      )),] ))));
  }
  

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    Size screenSize = MediaQuery.of(context).size;
    // final headers = ["Recommended For You", "Trending", "Newest"]; 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Most Trending News!"),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: screenSize.height/2,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.9),
            itemCount: decksData.decks.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
    return Center(
      child: GestureDetector(
        onTap: (){ 
        tappedDeck = decksData.decks[itemIndex];
        // print("[Default Screen] " +  "articles:" + tappedDeck.articles.toString());
        Navigator.push(context,
        new MaterialPageRoute(builder: (context)=> CrowdSourceGame(deckPk: tappedDeck.pk)));
        },
        onDoubleTap: (){ 
          
          showDialog( 
          context: context,
          builder: (BuildContext context){
          return AlertDialog(
          title: contains ?  
          new Text("You unstarred the ${doubleTappedDeck.title} deck") :
          new Text("You starred the ${doubleTappedDeck.title} deck"));
          
          });}, 

        child: SizedBox(
  
          width: 300.0,
          height: 600.0,
          child: Card(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: new Column(
            children: <Widget>[
              new Text(
              decksData.decks[itemIndex].title,
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent
              )),

              new Image.network(
                "https://3.bp.blogspot.com/-fiwFfX1nC54/XFLMbgvKcKI/AAAAAAAABfE/GcJEubU5M-YV5R9uXLpLPGltSGVigl-hwCLcBGAs/s1600/ca.png"
                // decksData.decks[itemIndex].thumbnail_url
              ),
            
              new Text(
              decksData.decks[itemIndex].description,
              style: new TextStyle(
                fontSize: 12.0,
                
                color: Colors.grey
              )),
              
              new Row(
                children: <Widget>[
                  new IconTheme(
                  data: new IconThemeData(
                      
                      color: Colors.yellow), 
                  // child: starIcon()),
                  child: Icon(Icons.star)),

                  new Text(
                     decksData.decks[itemIndex].stars.toString() + " stars",
                  )
                  
                ],
              )


            ],)
          //decksData.decks[itemIndex].title
            )))));
             
  }


  void starDecks() async {
    
    print("Uploading staredDecks to server..."); 

    token = await getMobileToken(); 
    username = await getUsername(); 
    
    Map<String, List<int>> payload = {
      "starred_decks" : starredDecks.toList()
    };
    var body = json.encode(payload); 
    print(body);
    print("lala");
    print(particularsUrl + username );
    final response = await patch(particularsUrl + username + "/", body:body, 
    headers: {HttpHeaders.authorizationHeader: 
    "Token $token", 
    HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200){
      print("200 success");
    } else {
      print(response.statusCode);
    }
    
    // final parsedResponse = json.decode(response); 
    // print(parsedResponse);


}
}

