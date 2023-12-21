import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/app.dart';

void main() {
  group('App Initialization Tests', () {
    testWidgets('MyApp builds correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Verify that MyApp builds the expected widgets.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
