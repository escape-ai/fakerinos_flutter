import 'dart:async';
import "package:flutter/material.dart"; 
import 'package:http/http.dart'; 
import 'dart:io';
import 'dart:convert';
import './data.dart';
import './dummyCard.dart';
import './activeCard.dart';
import '../../src/screens/partials/cards.dart';
import '../../src/screens/sharedPreferencesHelper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class CardDemo extends StatefulWidget {
  @override
  List<dynamic> articles;
  CardDemo({Key key, @required this.articles}) : super(key: key);
  CardDemoState createState() => new CardDemoState(articles);
  
}

class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
  // Articles is a variable passed from the previous screen
  List<dynamic> _articles;
  List<dynamic> fetchedCardsJson = []; 
  String token;

  // News data
  List data2; 
  List data;
  Cards fetchedCards; 
  CardDemoState(List<dynamic> articles){
    this._articles = articles;
    print("[CardDemoState]:" + _articles.toString());
  }

  

  void _fetchCardsData() async {
    print("fetching cards data"); 
    // final response = await get("https://fakerinos.herokuapp.com/api/articles/article/1", 
    // headers: {HttpHeaders.authorizationHeader: "Token 3ade3638c37c5370ab3c0679a7a8107eee133ed7"});
    // dynamic fetchedCardsJson = _articles.map((pk) => await get("https://fakerinos.herokuapp.com/api/articles/article/${pk}", 
    // headers: {HttpHeaders.authorizationHeader: "Token 3ade3638c37c5370ab3c0679a7a8107eee133ed7"}).then(
    //   (r) => jsonDecode(r.body)
    // ));
    
    token = await getMobileToken(); 

    final response = await get("https://fakerinos.herokuapp.com/api/articles/deck/1/articles/", 
      headers: {
      HttpHeaders.authorizationHeader: 
    "Token $token"});

    var decodedJson = jsonDecode(response.body);
    fetchedCards = Cards.fromJson(decodedJson);

    setState((){
      data = fetchedCards.cards.map((card) => new DecorationImage(image: new NetworkImage(card.thumbnail_url))).toList();
      data2 = fetchedCards.cards.map((card) => card.description).toList();
    });

    // for (int i =0; i< _articles.length; i++){
    //   print(_articles[i]);
    //   final response = await get("https://fakerinos.herokuapp.com/api/articles/deck/1/articles/", 
    //   headers: {
    //   HttpHeaders.authorizationHeader: 
    // "Token $token"});
    // // print(response.body);
    // var decodedJson = jsonDecode(response.body);
    // fetchedCardsJson.add(decodedJson);
    // } 
    // print(fetchedCardsJson);
    // Cards cards = Cards.fromJson(fetchedCardsJson);
    // // print(cards.toJson().toString());
    
    
    print("data2" + data2.toString());
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
     _fetchCardsData(); 
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
          var i = data.removeLast(); //************** */
          data.insert(0, i); //********************** */

          // var j = data2.removeLast();//************** */
          // data2.insert(0, j);

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
//choice:swipe right=0,left=1
//answer:correct:1;wrong=0
  dismissImg(DecorationImage img) {
    setState(() {
      choice=0;
      int answer=data3[data.indexOf(img)];
      if (answer==choice){result++;}
      data.remove(img);
      

    });
  }

  addImg(DecorationImage img) {
    setState(() {
      choice=1;
      int answer=data3[data.indexOf(img)];
      if (answer==choice){result++;}
      data.remove(img);
      selectedData.add(img);
      

    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    
    double initialBottom = 15.0;
    var dataLength = data == null? 1 : data.length;
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
            Icons.view_agenda, ////result bar
            color: Colors.cyan,
            size: 30.0,
          ),
        ),

        /////////////////////////////////////
        actions: <Widget>[
          new GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Container(
                margin: const EdgeInsets.all(15.0),
                //TODO:exit current game button
                child: new Icon(
                  Icons.clear, //exit corrent game
                  color: Colors.cyan,
                  size: 30.0,
                )),
          ),
        ],
        ///////////////////////////////////////////
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Questions",
              style: new TextStyle(
                  fontSize: 12.0,
                  letterSpacing: 3.5,
                  fontWeight: FontWeight.bold),
            ),
            new Container(
              width: 15.0,
              height: 15.0,
              margin: new EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.center,
              child: new Text(
                dataLength.toString(),
                style: new TextStyle(fontSize: 10.0),
              ),
              decoration: new BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle), //"question left mark"
            )
          ],
        ),
      ),
      body: 
    
          new Container(
            color: new Color.fromRGBO(30, 94, 175, 1.0),

            ///background color
            alignment: Alignment.center,
            child: dataLength > 0 ?
                data2 == null ? 
                RefreshProgressIndicator():
                 new Stack(
                    alignment: AlignmentDirectional.center,
                    children: data.map((item) {
                      if (data.indexOf(item) == dataLength - 1) {
                        return cardDemo(
                            item,
                            bottom.value,
                            right.value,
                            0.0,
                            backCardWidth + 10,
                            rotate.value,
                            rotate.value < -10 ? 0.1 : 0.0,
                            context,
                            dismissImg,
                            flag,
                            addImg,
                            swipeRight,
                            swipeLeft,
                            data2[data.indexOf(item)],
                            

                            );
                      } else {
                        backCardPosition = backCardPosition - 10;
                        backCardWidth = backCardWidth + 10;

                        return cardDemoDummy(item, backCardPosition, 0.0, 0.0,
                            backCardWidth, 0.0, 0.0, context);
                      }
                    }).toList()):
            AlertDialog(
          title: new Text("Well done!"),
          content: new Text("Not enough? Try out more decks on the home page! "),
          actions: <Widget> [new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                
                Navigator.of(context).pop();})])

                  
          ),
    

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        //tooltip: 'Increment',
        icon: Icon(Icons.check),
        label:Text(result.toString(),style: new TextStyle(color: Colors.white, fontSize: 30.0))
      ),
    ));
  }
} 
