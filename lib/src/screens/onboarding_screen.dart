import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import './interest_screen.dart';
import './particulars_screen.dart';

/// This is the main method of app, from here execution starts.
// void main() => runApp(App());

/// App widget class
/// 
class OnboardingScreen extends StatefulWidget{
  OnboardingScreen();
  createState(){
    return OnboardingScreenState(); 
  }
}

class OnboardingScreenState extends State<OnboardingScreen> {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFFB2EBF2),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/back1.jpg'),
        body: Text(
          'Fake news is becoming increasingly prevalent as perpetrators.',
        ),
        title: Text(
          'News',
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/back1.jpg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF80DEEA),
      iconImageAssetPath: 'assets/back2.jpg',
      body: Text(
        'In our card-swiping game,you will learn how to discern fakenews.',
      ),
      title: Text('Games'),
      mainImage: Image.asset(
        'assets/back3.jpg',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF0097A7),
      iconImageAssetPath: 'assets/back0.jpg',
      body: Text(
        'With training,you will be perceptive and able to combat fakenews.',
      ),
      title: Text('Awareness'),
      mainImage: Image.asset(
        'assets/back0.jpg',
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
                    builder: (context) => ParticularsScreen(),
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