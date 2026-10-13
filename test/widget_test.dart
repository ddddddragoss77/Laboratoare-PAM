// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:laboratorul_1/main.dart';

void main() {
  testWidgets('calculates average fuel consumption', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FuelApp());

    expect(find.text('Fuel Consumption Calculator'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), '500');
    await tester.enterText(find.byType(TextField).at(1), '40');
    await tester.tap(find.text('Calculate'));
    await tester.pump();

    expect(find.text('Average Consumption:\n8.00 L / 100 km'), findsOneWidget);
  });

  testWidgets('shows an error for invalid values', (WidgetTester tester) async {
    await tester.pumpWidget(const FuelApp());

    await tester.enterText(find.byType(TextField).at(0), '0');
    await tester.enterText(find.byType(TextField).at(1), '40');
    await tester.tap(find.text('Calculate'));
    await tester.pump();

    expect(
      find.text('Please enter valid numbers greater than 0'),
      findsOneWidget,
    );
  });
}
