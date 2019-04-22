import 'dart:async';
import "package:flutter/material.dart"; 
import 'package:http/http.dart'; 
import 'dart:io';
import 'dart:convert';
import './data.dart';
import './dummyCard.dart';
import './singleActiveCard.dart';
import '../../src/screens/partials/cards.dart';
import '../../src/screens/sharedPreferencesHelper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class CardDemo extends StatefulWidget {
  @override
  int deckPk;
  CardDemo({Key key, @required this.deckPk}) : super(key: key);
  CardDemoState createState() => new CardDemoState(deckPk);
}

class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
  // Articles is a variable passed from the previous screen
  int deckPk;
  List<dynamic> fetchedCardsJson = []; 
  String token;

  CardDemoState(int deckPk){
    this.deckPk = deckPk;
    print("[Deck pk to be queried]:" + deckPk.toString());
  }

  // News data
  List articlesDescription; 
  List articlesImage;
  List articlesHeadline;
  List<int> truth_values;
  List<int> pkList;
  Cards fetchedCards; 
  int dataLength;
  

  void _fetchCardsData(int deckPk) async {
    print("fetching cards data"); 

    token = await getMobileToken(); 
    var payload = {
      "deck": deckPk.toString()
    }; 
    print("Creating room...");
    await post("https://fakerinos.herokuapp.com/api/rooms/single-player/", 
      headers: {
      HttpHeaders.authorizationHeader: 
      "Token $token"}, body: payload);

    final response = await get("https://fakerinos.herokuapp.com/api/articles/deck/$deckPk/articles/", 
    headers: {
      HttpHeaders.authorizationHeader: 
      "Token $token"});
    // print(token);
  
    var decodedJson = jsonDecode(utf8.decode(response.bodyBytes));
    
    
    fetchedCards = Cards.fromJson(decodedJson);

    setState((){
      // articlesImage = fetchedCards.cards.map((card) => card.thumbnail_url != "" ? new DecorationImage(image: new NetworkImage(card.thumbnail_url)):
      // new DecorationImage(image: new ExactAssetImage('assets/logo.png'))).toList();
      articlesImage = fetchedCards.cards.map((card) => DecorationImage(image: new NetworkImage(card.thumbnail_url))).toList();
      articlesDescription = fetchedCards.cards.map((card) => card.text).toList();
      articlesHeadline = fetchedCards.cards.map((card) => card.headline).toList();
      truth_values = fetchedCards.cards.map((card)=> card.truth_value).toList();
      pkList = fetchedCards.cards.map((card)=> card.pk).toList();
      dataLength = articlesHeadline.length;
      print("DATALENGTH $dataLength");
     
    });
    
   }
  
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  int choice=0;
  int result=0;///////////////////
  
  // List data = imageData;
  // List data2 = newsData;
  List data3 = trueData;

  List selectedData = [];
  void initState() {
     _fetchCardsData(deckPk); 
    super.initState();

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);
///////////////////////////
    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = articlesImage.removeLast(); //************** */
          articlesImage.insert(0, i); //********************** */


          _buttonController.reset(); //************ */
        }
      });
    });
///////////////////////////////
    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    //////////////////////////////
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    ///////////////////////////
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }
//choice:swipe right=1,left=0
//answer:correct:1;wrong=0


  postSwipe(int cardPk, int user_choice) async{
    String swipe = user_choice == 1 ? "swipe_true" : "swipe_false";
    String url = "https://fakerinos.herokuapp.com/api/articles/article/$cardPk/$swipe/";
    print(url);

    print("Posting now...");
    await post(url, 
    headers: {
      HttpHeaders.authorizationHeader: 
      "Token $token"});
    print(cardPk);

  }

  finishGame(int score) async{
    
    var payload = {
      "score" : score.toString()
    };
    String url = "https://fakerinos.herokuapp.com/api/rooms/single-player/finish/";
    print(url);

    print("Finished game, updating...");
    final response = await post(url, 
    body: payload,
    headers: {
      HttpHeaders.authorizationHeader: 
      "Token $token"});

    print(response.body);
  }

  chooseFalse(int pk, String headline, int truth_value) {
    print("CHOSE FALSE");
    setState(() {

      if (truth_value==0){
        result+=100;
        print("You chose correctly!"); } 
      
      else {
      print("You chose wrongly!");
    }
      articlesHeadline.remove(headline);
    });
    postSwipe(pk, 0);
  }

  


  chooseTrue(int pk, String headline, int truth_value) {
    print("CHOSE TRUE");
    articlesHeadline.remove(headline);
    setState(() {
      
      if (truth_value == 1){
        print("You chose correctly!");
        result+=100;}else {
      print("You chose wrongly!");
    } 
       } );

    postSwipe(pk, 1);
  }

  swipeRight(int pk, String headline, int truth_value) {
    print("swipe right");
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
    chooseTrue(pk, headline, truth_value);
  }

  swipeLeft(int pk, String headline, int truth_value) {
    print("swipe left");
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
    chooseFalse(pk, headline, truth_value);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    
    double initialBottom = 15.0;
    dataLength = articlesHeadline == null ? 1: articlesHeadline.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return (new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor:
            new Color.fromRGBO(20, 94, 175, 1.0), /////////////////bar color
        centerTitle: true,
        leading: new Container(
          margin: const EdgeInsets.all(15.0),
          //TODO:icon to access other functions in the game, see avatar or settings...
          child: new Icon(
            Icons.question_answer, ////result bar
            color: Colors.white,
            size: 30.0,
          ),
        ),

        /////////////////////////////////////
        actions: <Widget>[
          new GestureDetector(
             key: Key("leaveSinglePremature"),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Container(
                margin: const EdgeInsets.all(15.0),
                //TODO:exit current game button
                child: new Icon(
                  Icons.clear, //exit current game
                  color: Colors.white,
                  size: 30.0,
                )),
          ),
        ],
        ///////////////////////////////////////////
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(10),
              child: new Text(
                "SINGLE PLAYER",
                style: new TextStyle(
                    
                    fontSize: 14.0,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold)),
            ),
            new Container(
              width: 30.0,
              height: 30.0,
              margin: new EdgeInsets.only(bottom: 5.0),
              alignment: Alignment.center,
              child: new Text(
                dataLength.toString(),
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black),
              ),
              decoration: new BoxDecoration(
                  
                  color: Colors.cyan[300],
                  shape: BoxShape.circle), //"question left mark"
            )
          ],
        ),
      ),


      body: new Container(
            color: new Color.fromRGBO(30, 94, 175, 0.50),
            ///background color
            // alignment: Alignment.topCenter,
            child: dataLength > 0 ? //show alertDialogue if <= 0 
                articlesHeadline == null ? 
                RefreshProgressIndicator():
                 new Stack(
                    alignment: AlignmentDirectional.center,
                    children: articlesHeadline.map((headline) {
                      int idx = articlesHeadline.indexOf(headline);
                      print("idx: $idx");
                      if (articlesHeadline.indexOf(headline) == dataLength - 1) {
                      
                        String currentDescription = articlesDescription[idx];

                        return singleActiveCard(
                            pkList[idx],
                            articlesImage[idx],
                            bottom.value,
                            right.value,
                            0.0,
                            backCardWidth + 10,
                            rotate.value,
                            rotate.value < -10 ? 0.1 : 0.0,
                            context,
                            flag,
                            chooseTrue,
                            chooseFalse,
                            swipeRight,
                            swipeLeft,
                            currentDescription,
                            headline,
                            truth_values[idx]
                            );
                      } else {
                        backCardPosition = backCardPosition - 10;
                        backCardWidth = backCardWidth + 10;

                        return cardDemoDummy(articlesImage[0], backCardPosition, 0.0, 0.0,
                            backCardWidth, 0.0, 0.0, context);
                      }
                    }).toList()):
                    new AlertDialog(
                      title: new Text("Well done!"),
                      content: new Text("Not enough? Try out more decks on the home page! "),
                      actions: <Widget> [new FlatButton(
                          child: new Text("Close"),
                          key: Key("leaveSingleNormal"),
                          onPressed: () {
                            print("Posting Game Results");
                            print(result);
                            finishGame(result);
                            Navigator.of(context).pop();})])
            

                  
          ),
    

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: result > 0 ? Colors.green : Colors.blue,
        onPressed: (){},
        //tooltip: 'Increment',
        icon: Icon(Icons.check),
        label:Text((result).toString(),style: new TextStyle(color: Colors.white, fontSize: 30.0))
      ),
    ));
  }
} 
