import 'package:flutter/material.dart';

Positioned cardDemoDummy(
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  // Size screenSize=(500.0,200.0);
  // print("dummyCard");
  String loremText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec qu...";
  // print("Card");
  return new Positioned(
    top: screenSize.height/100 * 1,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    // left: flag == 1 ? right != 0.0 ? right : null : null,
    
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
                        child: new Text("Loading...", 
                        textAlign: TextAlign.center,
                      style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
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
                        child: new Text(loremText,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15,
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
                                
                                    // chooseFalse(headline);
                                    // new Timer(Duration(milliseconds: 5), () => chooseFalse(headline));
                                  },
                                  child: new Container(
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
                                  
                                    // new Timer(Duration(milliseconds: 5), () => chooseTrue(headline));
                           
                                  },
                                  child: new Container(
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
              );
}
