// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
//import '../lib/src/app.dart';
// import 'package:flutter_test/flutter_test.dart' as WTest;
// import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/gestures.dart';

void main() {
  final descriptionTextFinder = find.byValueKey('description');
    final signUpButtonFinder = find.byValueKey('Sign up');

    final usernameFinder = find.byValueKey('username');
    final emailFinder = find.byValueKey('email');
    final passwordFinder = find.byValueKey('password');
    final confirmedPasswordFinder = find.byValueKey('confirmed password');
    final submitButtonFinder = find.byValueKey('submit button');
    final snackbarFinder = find.byValueKey("snackbar");
    //interestscreen.dart
    final skipInterestButton=find.byValueKey("skipInterest");
    final nextInterestButton=find.byValueKey("nextInterest");
    //interest tabs
    final List<String> _InterestTaps=["Sports","Finance",];
//leaderboard
final viewLeaderboardButton=find.byValueKey( "ViewLeaderboard");
final backfromLeaderboardButton=find.byValueKey( "backFromLeaderboard");
final enterSingleDeckButton=find.byValueKey("enterSingleDeck");
//singlegame
final SingleTapTrue=find.byValueKey("SingleTapTrue");
final SingleTapFalse=find.byValueKey("SingleTapFalse");
final leaveSinglePremature=find.byValueKey("leaveSinglePremature");
final leaveSingleNormal=find.byValueKey("leaveSingleNormal");
final viewPersonalProfile=find.byValueKey("viewPersonalProfile");
final enterMultiGame=find.byValueKey("enterMultiGame");




   
    
  group('Starting the app:', () {
    // First, define the app Finders. We can use these to locate Widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    

    //key: Key('counter')
    

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    //1 test
     test('check flutter driver health', () async {
  Health health = await driver.checkHealth();
  print(health.status);
});
    //2 test
    test('description is available', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(descriptionTextFinder), 
      "Think you can tell Fake from Real? \n Come put your skills to a test!");
    });
    //3 test
    test('taps sign up button', () async {
      // First, tap on the button
      await driver.tap(signUpButtonFinder);

      // Then, verify the counter text has been incremented by 1
     
       //expect(result, 'hello');
      // expect(await driver.getText(counterTextFinder), "1");
    });
    // 4 test
  test('fill up common password', () async {
      // First, tap on the button
      await driver.tap(usernameFinder);
      await driver.enterText("wakawaka2");

      await driver.tap(emailFinder);
      await driver.enterText("waka2@waka.com");

      await driver.tap(passwordFinder);
      await driver.enterText("lionell46");
      
      await driver.tap(confirmedPasswordFinder);
      await driver.enterText("lionell46");

      await driver.tap(submitButtonFinder);
      // Then, verify the counter text has been incremented by 1



      // await driver.pump(new Duration(milliseconds: 50));

    //   expect(await driver.getText(snackbarFinder, timeout: new Duration(milliseconds: 4000) ), 
    //   "Error: This password is too short. It must contain at least 8 characters");
    // });
  });
  //interest_screen.dart
  //  WTest.testWidgets('Tap on interest taps', (WTest.WidgetTester tester) async {
  //   await tester.tapAt(const Offset(10.0, 10.0));
  // });
//TODO:gesture scrolling!
  test('choose interests', () async {
    //test scrolling

    //tap on the button
    //await driver.tap(skipInterestButton);

    //or:
    //choose cards then tap on next button
    //final List<String> _InterestTaps=["ports","Education","Economics"];
    
  //    for(var i = 0;i<_InterestTaps.length;i++){
  //      await driver.tap(find.byValueKey("TAP${_InterestTaps[i]}"));  
  
  //   print("Tapped $i : ${_InterestTaps[i]} ");

  // }

  await driver.tap(skipInterestButton);  

   
  });
  //leaderboard
  test('see leaderboard', () async {
    await driver.tap(viewLeaderboardButton);
  });
  //TODO:gesture scrolling!
  test('back from leaderboard', () async {
    await driver.tap(backfromLeaderboardButton);
  });
  //enter single player mode
  //TODO:gesture ontap!!!!!!!!!!!!!!!!!
  test('enter single player decks', () async {
    await driver.tap(enterSingleDeckButton);
  });
  //single game:
   //TODO:gesturedetector slide(to ondispose)!!!!!!!!!!!!!!!!!
  test('Single game Tapped True', () async {
    await driver.tap(SingleTapTrue);
  });
  test('Single game Tapped False', () async {
    await driver.tap(SingleTapFalse);
  });
  //finish game premature
  //TODO:gesture tap!!!!
  test('leave Single Prematurely', () async {
    await driver.tap(leaveSinglePremature);
  });
  //finish game normal

  test('leave Single Normally', () async {
    await driver.tap(leaveSingleNormal);
  });
  //after leave game back to home page

  //how to open drawer?--open side bar
  //then check personal profile
  test('view Personal Profile', () async {
    await driver.tap(viewPersonalProfile);
  });

  //TODO:go back from personalProfile to mainpage

  test('enter Multi Game', () async {
    await driver.tap(enterMultiGame);
  });
  
  //backfrom multigame
  test("back from Multi Loading", () async {
    await driver.tap(backfromMultiLoad);
  });


  



});}