import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import "../home_screen.dart";


class GameRule extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFFB2EBF2),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/swipe.png'),
        body: Text(
          'Swipe Left if you think the news is Fake. Swipe Right if you think the news is True.',
        ),
        title: Text(
          'Gesture',
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/swipe.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF80DEEA),
      iconImageAssetPath: 'assets/tap.png',
      body: Text(
        'Tap on the news to read more details on the news.',
      ),
      title: Text('More info'),
      mainImage: Image.asset(
        'assets/tap.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF0097A7),
      iconImageAssetPath: 'assets/back2.jpg',
      body: Text(
        'Every card swiped correctly gives you one point. Are you ready? Game on!',
      ),
      title: Text('Ready?'),
      mainImage: Image.asset(
        'assets/back2.jpg',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', //title of app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter(
              pages,
              onTapDoneButton: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ), //MaterialPageRoute
                );
              },
              pageButtonTextStyles: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

/// Home Page of our example app.


