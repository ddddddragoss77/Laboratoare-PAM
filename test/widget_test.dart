import 'package:flutter_test/flutter_test.dart';
import 'package:laboratorul_2/main.dart';

void main() {
  testWidgets('Renders Fitness Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FitnessApp());

    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text("Today's Challenge"), findsOneWidget);
    expect(find.text('Featured Plan'), findsOneWidget);
    expect(find.text('Workout Programs'), findsOneWidget);
  });
}
