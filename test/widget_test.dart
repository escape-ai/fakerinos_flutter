import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import '../lib/src/MyWidget.dart';

void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('HomeScreen has a title ', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(MyWidget(title: 'FAKERINOS!', message: 'M'));

    // Create our Finders
    final titleFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('HomeScreen has a message ', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(MyWidget(title: 'T', message: 'Think you can tell Fake from Real? Come put your skills to a test!'));

    // Create our Finders
    final messageFinder = find.text('Think you can tell Fake from Real? Come put your skills to a test!');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(messageFinder, findsOneWidget);
  });

testWidgets('HomeScreen has 2 buttons', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(MyWidget(title: 'Sign Up', message: 'Log in'));

    // Create our Finders
    final buttonFinder1 = find.text('Sign Up');
    final buttonFinder2 = find.text('Log in');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(buttonFinder1, findsOneWidget);
    expect(buttonFinder2, findsOneWidget);
  });
}

class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAKERINOS!',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}