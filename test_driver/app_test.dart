// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
//import '../lib/src/app.dart';
//import 'package:flutter_test/flutter_test.dart' as WTest;
//import 'package:flutter/widgets.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/gestures.dart';

void main() {
  //info to test
  final String testName="Lionell7722";
  final String testemail=testName+"@126.com";
  final descriptionTextFinder = find.byValueKey('description');
  //signup
    final signUpButtonFinder = find.byValueKey('Sign up');
    final usernameFinder = find.byValueKey('username');
    final emailFinder = find.byValueKey('email');
    final passwordFinder = find.byValueKey('password');
    final confirmedPasswordFinder = find.byValueKey('confirmed password');
    final submitButtonFinder = find.byValueKey('submit button');
    final snackbarFinder = find.byValueKey("snackbar");
    //loginin
    final chooseLogin = find.byValueKey('chooseLogin');
    final submitLogin =find.byValueKey("submitLogin");
    final fullinName=find.byValueKey("fullinName");
    final fullinPassword=find.byValueKey("fullinPassword");
    //detail setting after login(particular screen)


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
//multigame
final enterMultiGame=find.byValueKey("enterMultiGame");
final backfromMultiLoad=find.byValueKey("backfromMultiLoad");



   
    
  group('Starting the app:', () {
    FlutterDriver driver;
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
      await driver.enterText(testName);

      await driver.tap(emailFinder);
      await driver.enterText(testemail);

      await driver.tap(passwordFinder);
      await driver.enterText("lionell46");
      
      await driver.tap(confirmedPasswordFinder);
      await driver.enterText("lionell46");
      await driver.tap(submitButtonFinder);
  });
//TODO:gesture scrolling!
  test('choose interests', () async {
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
  test('leave Single Prematurely', () async {
    await driver.tap(leaveSinglePremature);
  });

  test('view Personal Profile', () async {
    await driver.tap(viewPersonalProfile);
  });
  
  test('enter Multi Game', () async {
    await driver.tap(enterMultiGame);
  });
  
  //backfrom multigame
  test("back from Multi Loading", () async {
    await driver.tap(backfromMultiLoad);
  });
}
);
group('Register with same account:', () {
    FlutterDriver driver;
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
      await driver.tap(signUpButtonFinder);
    });
    // 4 test
  test('fill up common password', () async {
      // First, tap on the button
      await driver.tap(usernameFinder);
      await driver.enterText(testName);

      await driver.tap(emailFinder);
      await driver.enterText(testemail);

      await driver.tap(passwordFinder);
      await driver.enterText("lionell46");
      
      await driver.tap(confirmedPasswordFinder);
      await driver.enterText("lionell46");

      await driver.tap(submitButtonFinder);
     

     
  });
 
}
);
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
group('Revisit the app by login:', () {
    FlutterDriver driver;
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
    test('taps login button', () async {
      await driver.tap(chooseLogin);
    });
    // 4 test
  test('fill up common password', () async {
      // First, tap on the button
    

      await driver.tap(fullinName);
      await driver.enterText("lionell46");

      await driver.tap(fullinPassword);
      await driver.enterText("lionell46");

      await driver.tap(submitLogin);
  });

//TODO:gesture scrolling!
  test('choose interests', () async {
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
}
);


}