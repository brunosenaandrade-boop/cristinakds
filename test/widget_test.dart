import 'package:flutter_test/flutter_test.dart';
import 'package:cristina_kids/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CristinaKidsApp());
    expect(find.text('CristinaKids'), findsOneWidget);
    expect(find.text('JOGAR'), findsOneWidget);
  });
}
