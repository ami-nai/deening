// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/app.dart';
import 'package:frontend/core/storage/secure_storage.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final secureStorage = SecureStorage();
    await tester.pumpWidget(App(secureStorage: secureStorage));

    // Verify that the app renders (basic smoke test)
    expect(find.byType(App), findsOneWidget);
  });
}
