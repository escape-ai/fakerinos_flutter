import 'dart:math';

import './detail.dart';
import 'package:flutter/material.dart';

Positioned cardDemo(
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag,
    Function addImg,
    Function swipeRight,
    Function swipeLeft,
    String newsContent) {
  Size screenSize = MediaQuery.of(context).size;
  // print("Card");
  return new Positioned(
    bottom: 100.0 + bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new Key(new Random().toString()),
      crossAxisEndOffset: -0.3,
      onResize: () {
      },
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart)//swipe to right
          dismissImg(img);
        else
          addImg(img);
        
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
                //TODO(Yunyi): specify detailpage based on the news content
                Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new DetailPage(type: img),
                    ));
              },
              child: new Card(
                color: Colors.transparent,
                elevation: 4.0,
                child: new Container(
                  alignment: Alignment.center,
                  width: screenSize.width / 1.2 + cardWidth,
                  height: screenSize.height / 1.7,
                  decoration: new BoxDecoration(
                    color: new Color.fromRGBO(121, 114, 173, 1.0),//card color!!!!!!!!!!
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: screenSize.width / 1.2 + cardWidth,
                        height: screenSize.height / 2.2,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(8.0),
                              topRight: new Radius.circular(8.0)),
                          image: img,
                        ),
                      ),
                      new Container(
                          width: screenSize.width / 1.2 + cardWidth,
                          height:
                              screenSize.height / 1.7 - screenSize.height / 2.2,
                          alignment: Alignment.center,
                          child: Text(newsContent),
                          //child: new Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // children: <Widget>[
                            //   new FlatButton(
                            //       padding: new EdgeInsets.all(0.0),
                            //       onPressed: () {
                            //         swipeLeft();
                            //       },
                            //       child: new Container(
                            //         height: 60.0,
                            //         width: 130.0,
                            //         alignment: Alignment.center,
                            //         decoration: new BoxDecoration(
                            //           color: Colors.red,
                            //           borderRadius:
                            //               new BorderRadius.circular(60.0),
                            //         ),
                            //         child: new Text(
                            //           "False",
                            //           style: new TextStyle(color: Colors.white),
                            //         ),
                            //       )),
                            //   new FlatButton(
                            //       padding: new EdgeInsets.all(0.0),
                            //       onPressed: () {
                            //         swipeRight();
                            //       },
                            //       child: new Container(
                            //         height: 60.0,
                            //         width: 130.0,
                            //         alignment: Alignment.center,
                            //         decoration: new BoxDecoration(
                            //           color: Colors.cyan,
                            //           borderRadius:
                            //               new BorderRadius.circular(60.0),
                            //         ),
                            //         child: new Text(
                            //           "True",
                            //           style: new TextStyle(color: Colors.white),
                            //         ),
                            //       ))
                            // ],
                          )]
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
