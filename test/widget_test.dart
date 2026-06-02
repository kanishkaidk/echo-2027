// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_app/main.dart';

void main() {
  testWidgets('Game loads and displays intro screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const EchoesOf2076App());

    // Verify that the main title is displayed.
    expect(find.text('ECHOES OF 2076'), findsOneWidget);

    // Verify that the subtitle is displayed.
    expect(find.text('A cyberpunk underground story'), findsOneWidget);

    // Verify that the BEGIN button is displayed.
    expect(find.text('BEGIN'), findsOneWidget);
  });
}
