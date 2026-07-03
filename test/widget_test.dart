import 'package:flutter_test/flutter_test.dart';
import 'package:shamba_ai/main.dart';

void main() {
  testWidgets('ShambaAI app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShambaAIApp());
    expect(find.byType(ShambaAIApp), findsOneWidget);
  });
}
