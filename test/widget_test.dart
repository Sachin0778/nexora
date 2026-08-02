import 'package:flutter_test/flutter_test.dart';
import 'package:nexora/app/app.dart';
import 'package:nexora/core/di/injection.dart';

void main() {
  setUpAll(() async {
    await configureDependencies();
  });

  testWidgets('renders bottom navigation tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const NexoraApp());

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Profile'), findsOneWidget);
  });
}
