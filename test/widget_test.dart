// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/src/screens/welcome_screen.dart';
import '../lib/src/screens/login_screen.dart';

// import 'package:login_page/main.dart';

void main() {
  testWidgets('Welcome Screen Initial Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(WelcomeScreen());

    // Verify that our counter starts at 0.
    expect(find.text('FAKERINOS!'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Login Screen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(LoginScreen());

    // Verify that our counter starts at 0.
    expect(find.byType(RaisedButton), findsOneWidget);

    // await tester.tap(find.byType(RaisedButton)); 
    // expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
