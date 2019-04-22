import "package:flutter/material.dart"; 
import 'package:http/http.dart'; 
import 'dart:io';
import 'dart:convert';
import "../../SwipeAnimation/index.dart";
import "./cards.dart";
import "../../Session.dart";
import "./decks.dart"; 
import "../leaderboard/leaderboardPage.dart";
import '../sharedPreferencesHelper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../SwipeAnimation/crowdSourceGame.dart';


class CrowdSourceScreen extends StatefulWidget{
  @override
   

  createState(){
    return CrowdSourceScreenState(); 
  }

  
}

class CrowdSourceScreenState extends State<CrowdSourceScreen>{

  Decks decksData;
  Deck doubleTappedDeck;
  Deck tappedDeck; 
  final Set<int> starredDecks  = new Set<int>(); 
  String particularsUrl = "https://fakerinos.herokuapp.com/api/accounts/profile/";
  String username;
  String token; 
  bool contains;
  double screenUnitHeight; 
  double screenUnitWidth; 

  @override
  void initState(){
    super.initState();
    print("CrowdSource Screen w Decks initializing");
    
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
        decksData.reverse();
      
      });
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load cards');
    }
  }
  @override
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    screenUnitHeight = screenSize.height/100; 
    screenUnitWidth = screenSize.width/100; 
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Center (
        child: new Container(
        width: 500,
        height: 1000,
        child: decksData == null ?
        Center(child: SpinKitChasingDots(size: 50, color: Colors.blue, duration: Duration(milliseconds: 2500),),
        ) :Column(children: <Widget>[
        // leaderboardButton(),
        _buildCarousel(context, 0),] ))));
  }
  

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    final headers = ["Latest Trending" ]; 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding( padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Text(headers[carouselIndex], 
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Niagaraphobia'),)
        )
        ,

        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: screenUnitHeight * 70,
          width: screenUnitWidth * 95,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.75),
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
        key:Key("enterSingleDeck"),
        onTap: (){ 
        tappedDeck = decksData.decks[itemIndex];
        // print("[Default Screen] " +  "articles:" + tappedDeck.articles.toString());
        Navigator.push(context,
        new MaterialPageRoute(builder: (context)=> CrowdSourceCardDemo(deckPk: tappedDeck.pk)));
        },
        onDoubleTap: (){ 
          doubleTappedDeck = decksData.decks[itemIndex]; 
          setState(() {
              decksData.decks[itemIndex].stars+=1;
                    });
          // Adding or removing deck logic 
          starredDecks.contains(doubleTappedDeck.pk) ? 
          contains = true : contains = false; 
          contains ? starredDecks.remove(doubleTappedDeck.pk) : 
          starredDecks.add(doubleTappedDeck.pk);

          print(starredDecks);
          starDecks();
          showDialog( 
          context: context,
          builder: (BuildContext context){
          return AlertDialog(
          title: contains ?  
          new Text("You unstarred the ${doubleTappedDeck.title} deck") :
          new Text("You starred the ${doubleTappedDeck.title} deck"));
          
          });}, 

        child: SizedBox(
  
          width: screenUnitWidth * 90,
          height: screenUnitHeight * 60,
          child: Card(
            color: Colors.yellow[700],
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: new Column(
            children: <Widget>[
              new Text(
              decksData.decks[itemIndex].title,
              style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent
              )),
              
              decksData.decks[itemIndex].thumbnail_url == null ? 
              new Container(
                height: screenUnitHeight * 30,
                width: screenUnitWidth * 50,
                child: Image.asset('assets/logo.png'),
                ):
              new Container(
                height: screenUnitHeight * 30,
                width: screenUnitWidth * 50,
                child: Image.network(decksData.decks[itemIndex].thumbnail_url)
                ),
            
              new Text(
              decksData.decks[itemIndex].description,
              style: new TextStyle(
                fontSize: 14.0,
                
                color: Colors.blue,
                fontFamily: "Roboto"
              )),
              
              new Row(
                children: <Widget>[
                  new IconTheme(
                  data: new IconThemeData(
                      
                      color: contains == null ?  Colors.grey :
                      contains == true ? 
                      Colors.blue[300] : Colors.grey), 
                  child: new Icon(
                    
                    Icons.star,
                  
                    size: 40,)),

                  new Text(
                     decksData.decks[itemIndex].stars.toString() + " stars",
                     style: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.bold
                     )
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

Widget leaderboardButton(){
  return new Container(
          padding: EdgeInsets.only(top: screenUnitHeight * 5),
          child: ButtonTheme(
            minWidth: 350,
            height: 50,
            child: new RaisedButton(
            color: Colors.cyan[400],
            textColor: Colors.black,
            key: Key("ViewLeaderboard"),
            child: new Text("See the leaderboard",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            onPressed: () => Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new LeaderPage())),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
        );
}
}

