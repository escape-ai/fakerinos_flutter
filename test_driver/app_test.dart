// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
// import '../lib/src/app.dart';

void main() {
  group('Initilizing the app:', () {
    // First, define the Finders. We can use these to locate Widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final descriptionTextFinder = find.byValueKey('description');
    final signUpButtonFinder = find.byValueKey('Sign up');

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
  });
}