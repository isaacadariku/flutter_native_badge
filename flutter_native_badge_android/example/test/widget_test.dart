import 'package:flutter_native_badge_android_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('FNB Android Example'), findsOneWidget);
    expect(find.text('Increment'), findsOneWidget);
  });
}
