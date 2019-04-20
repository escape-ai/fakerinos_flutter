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
import 'package:countdown/countdown.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;



class MultiplayerGame extends StatefulWidget {
  @override
  createState() => new MultiplayerGameState();
  
}

class MultiplayerGameState extends State<MultiplayerGame> with TickerProviderStateMixin {
  // Articles is a variable passed from the previous screen
  int deckPk = 2; 
  List<dynamic> fetchedCardsJson = []; 
  String token;
  int val = 10;
  CountDown cd;
  bool canStart = false; 
  
  // News data
  List articlesDescription; 
  List articlesImage;
  List articlesHeadline;
  Cards fetchedCards; 
  Size screenSize;
  
  

  void _fetchCardsData(int deckPk) async {
    print("fetching cards data"); 

    token = await getMobileToken(); 

    final response = await get("https://fakerinos.herokuapp.com/api/articles/deck/$deckPk/articles/", 
      headers: {
      HttpHeaders.authorizationHeader: 
    "Token $token"});

    var decodedJson = jsonDecode(response.body);
    print(decodedJson);
    fetchedCards = Cards.fromJson(decodedJson);

    setState((){
      articlesImage = fetchedCards.cards.map((card) => new DecorationImage(image: new NetworkImage(card.thumbnail_url))).toList();
      articlesDescription = fetchedCards.cards.map((card) => card.description).toList();
      articlesHeadline = fetchedCards.cards.map((card) => card.title).toList();

      print("Headlines:" + articlesHeadline.toString());
    });
    
    print("Articles data:" + articlesDescription.toString());
    countdown(10);
    
   }


   Widget timerWidget(){
     return new Container(
       height: screenSize.height/100 * 8,
        child: new Center(
          child: new Text(val == 0 ? "TIMEOUT" : val.toString(), style: new TextStyle(fontSize: 40))));
   }
   

   Widget completeAlert(){
     return new AlertDialog(
          title: new Text("Well done!"),
          content: new Text("Not enough? Try out more decks on the home page! "),
          actions: <Widget> [new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                
                Navigator.of(context).pop();})]);
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

  void countdown(int numSeconds){
    print("countdown() called");
    cd = new CountDown(new Duration(seconds: numSeconds));
    StreamSubscription sub = cd.stream.listen(null);
    sub.onDone(() {
      print("removing");
      swipeLeft();
    });
    sub.onData((d) {
      if (val == d.inSeconds) return;
      print("onData: d.inSeconds=${d.inSeconds}");
      setState((){
        val = d.inSeconds;
      });
    });
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
  dismissImg(DecorationImage img) {
    setState(() {
      choice=0;
      int answer=data3[articlesImage.indexOf(img)];
      if (answer==choice){result++;}
      articlesImage.remove(img);
      

    });
  }

  addImg(DecorationImage img) {
    setState(() {
      choice=1;
      int answer=data3[articlesImage.indexOf(img)];
      if (answer==choice){result++;}
      articlesImage.remove(img);
      // selectedData.add(img);
      

    });
  }

  changeTime(int d){
    setState((){
      val = d;
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
    screenSize = MediaQuery.of(context).size;
    timeDilation = 0.4;
    
    double initialBottom = 15.0;
    var dataLength = articlesImage == null? 1 : articlesImage.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return new Scaffold(
      // floatingActionButton: new FloatingActionButton(
      //   onPressed: () => _controller.forward(from: 0.0)
      // ),
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
                "MULTI PLAYER",
                style: new TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold)),
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
            height: screenSize.height/10 * 8,
            width: screenSize.width,
            color: new Color.fromRGBO(30, 94, 175, 0.50),
            child: new Column(children: <Widget>[
              timerWidget(),
              dataLength > 0 ?
                articlesDescription == null ? 
                Center(child: RefreshProgressIndicator()):
                 new Container(
                   height: screenSize.height/10 * 7,
                   width: screenSize.width,
                   child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: articlesImage.map((item) {
                      if (articlesImage.indexOf(item) == dataLength - 1) {
                        int idx = articlesImage.indexOf(item);
                        String currentDescription = articlesDescription[articlesImage.indexOf(item)];

                        return cardDemo(
                            cd,
                            countdown,
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
                            currentDescription * 2,
                            articlesHeadline[idx]
                            );
                      } else {
                        backCardPosition = backCardPosition - 10;
                        backCardWidth = backCardWidth + 10;

                        return cardDemoDummy(item, backCardPosition, 0.0, 0.0,
                            backCardWidth, 0.0, 0.0, context);
                      }
                    }).toList())): completeAlert()
            
                 ],
          )
        ),
        
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        //tooltip: 'Increment',
        icon: Icon(Icons.check),
        label:Text(result.toString(),style: new TextStyle(color: Colors.white, fontSize: 30.0))
      ),
    );}
  
} 
