import 'package:flutter_test/flutter_test.dart';
import 'package:almadaralfadi_website/main.dart';

void main() {
  testWidgets('Home page loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SilverOrbitApp());
    expect(find.text('وقت السفر'), findsOneWidget);
  });
}