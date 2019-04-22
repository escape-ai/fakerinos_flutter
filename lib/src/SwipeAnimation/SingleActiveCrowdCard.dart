import 'dart:math';

import './detail.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:countdown/countdown.dart';

Positioned SingleActiveCrowdCard(
    int pk,
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    int flag,
    Function chooseTrue,
    Function chooseFalse,
    Function swipeRight,
    Function swipeLeft,
    String description,
    String headline,
    int truth_value) {
  

  String truncate(String stringArg, int length){
    if (stringArg.length > length){
      return stringArg.substring(0, length) + "...";
    }
    else {
      return stringArg;
    }
  }

  print("[singleActiveCard] truth_value is $truth_value");

  Size screenSize = MediaQuery.of(context).size;
  String loremText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec qu...";
  // print("Card");
  return new Positioned(
    top: screenSize.height/100 * 1,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new Key(new Random().toString()),
      crossAxisEndOffset: -0.3,
      onResize: () {
      },
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart){
          //swipe left
          chooseFalse(pk, headline, truth_value); }
        else{
          //swipe right
          chooseTrue(pk, headline, truth_value);
        }
      },
      child: new Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: new Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child: new RotationTransition(
          turns: new AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: new Hero(
            tag: "img",
            child: new GestureDetector(
              onTap: () {

                print("Card was tapped!");
                print(description);
                //TODO(Yunyi): specify detailpage based on the news content
                Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new DetailPage(
                      headlines: headline, 
                      description: description,
                      img: img ),
                    ));
              },
              child: new Card(
                color: Colors.transparent,
                elevation: 10.0,
                child: new Container(
                  alignment: Alignment.center,
                  width: screenSize.width / 1.2 + cardWidth,
                  height: screenSize.height / 1.6,
                  decoration: new BoxDecoration(
                    color: new Color.fromRGBO(121, 114, 173, 1.0),//card color
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.all(10),
                        child: new Text(headline, 
                        textAlign: TextAlign.center,
                      style: TextStyle(
                  color: Colors.white,
                  fontSize: 1600/headline.length + 10,
                  fontFamily: 'Niagaraphobia'))
                      ),
                      new Container(
                        width: screenSize.width / 1.2 + cardWidth,
                        height: screenSize.height / 4.5,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(8.0),
                              topRight: new Radius.circular(8.0)),
                          image: img,
                        ),
                      ),
                      new Container(
                        height: screenSize.height / 10,
                        padding: EdgeInsets.all(10),
                        child: new Text(description.length < 2 ? 
                        loremText :
                        truncate(description, 100),
                        
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 13,
                        fontFamily: "Roboto")),
                        
                      ),
                      new Container(
                          width: screenSize.width / 1.2 + cardWidth,
                          height:
                              screenSize.height / 1.7 - screenSize.height / 2.2,
                          alignment: Alignment.center,
                          // Buttons
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new FlatButton(
                                  padding: new EdgeInsets.all(0.0),
                                  onPressed: () {
                                    swipeLeft(pk, headline, truth_value);
                                    // chooseFalse(headline);
                                    // new Timer(Duration(milliseconds: 5), () => chooseFalse(headline));
                                  },
                                  child: new Container(
                                    padding: EdgeInsets.only(top: 5),
                                    height: screenSize.height/17,
                                    width: screenSize.width / 2.8,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          new BorderRadius.circular(60.0),
                                    ),
                                    child: new Text(
                                      "False",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 3,
                                        fontSize: 30,
                                        fontFamily: 'Niagaraphobia'),
                                    ),
                                  )),
                              new FlatButton(
                                  padding: new EdgeInsets.all(0.0),
                                  onPressed: () {
                                    
                                    swipeRight(pk, headline, truth_value);
                                    
                                    // new Timer(Duration(milliseconds: 5), () => chooseTrue(headline));
                           
                                  },
                                  child: new Container(
                                    padding: EdgeInsets.only(top: 5),
                                    height: screenSize.height/17,
                                    width: screenSize.width / 2.8,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius:
                                          new BorderRadius.circular(60.0),
                                    ),
                                    child: new Text(
                                      "True",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        letterSpacing: 3,
                                        fontFamily: 'Niagaraphobia'),
                                    ),
                                  ))
                            ],
                          ))]
                  ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
}
