import 'package:flutter_test/flutter_test.dart';
import 'package:bomb_study/app.dart';

void main() {
  testWidgets('B.O.M.B app loads home dashboard and reader', (WidgetTester tester) async {
    await tester.pumpWidget(const BombApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('B.O.M.B'), findsWidgets);
    expect(find.textContaining('Streak'), findsWidgets);
  });
}
