// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertest/main.dart';
import 'package:fluttertest/models/appconfig.dart';
import 'package:fluttertest/config/environment.dart';

void main() {
  testWidgets('App should show login screen', (WidgetTester tester) async {
    // Create a test config
    final testConfig = AppConfig(
      baseUrl: Environment.apiBaseUrl,
      menuTexts: {'test': 'Test'},
      menuIcons: {'test': Icons.home},
      menuActiveIcons: {'test': Icons.home_filled},
      colorPalette: {
        'primary': Colors.blue,
        'background': Colors.white,
        'accent': Colors.orange,
        'text': Colors.black,
      },
    );
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(appConfig: testConfig));
    await tester.pumpAndSettle();

    // Verify that we're on the login screen
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Email and password fields
    expect(find.text('SIGN IN'), findsOneWidget);
  });
}
