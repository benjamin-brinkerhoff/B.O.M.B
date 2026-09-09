import 'package:flutter_test/flutter_test.dart';
import 'package:bomb_study/app.dart';

void main() {
  testWidgets('B.O.M.B app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BombApp());
    expect(find.text('B.O.M.B'), findsWidgets);
  });
}
