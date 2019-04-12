// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
// import '../lib/src/app.dart';

void main() {
  group('Starting the app:', () {
    // First, define the app Finders. We can use these to locate Widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final descriptionTextFinder = find.byValueKey('description');
    final signUpButtonFinder = find.byValueKey('Sign up');

    final usernameFinder = find.byValueKey('username');
    final emailFinder = find.byValueKey('email');
    final passwordFinder = find.byValueKey('password');
    final confirmedPasswordFinder = find.byValueKey('confirmed password');
    final submitButtonFinder = find.byValueKey('submit button');
    final snackbarFinder = find.byValueKey("snackbar");
    

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

    test('description is available', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(descriptionTextFinder), 
      "Think you can tell Fake from Real? \n Come put your skills to a test!");
    });

    test('taps sign up button', () async {
      // First, tap on the button
      await driver.tap(signUpButtonFinder);

      // Then, verify the counter text has been incremented by 1
      // expect(await driver.getText(counterTextFinder), "1");
    });

  test('fill up common password', () async {
      // First, tap on the button
      await driver.tap(usernameFinder);
      await driver.enterText("wakawaka");

      await driver.tap(emailFinder);
      await driver.enterText("waka@waka.com");

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

});}