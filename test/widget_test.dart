import 'package:flutter_test/flutter_test.dart';

import 'package:elfulk/src/core/app/elfulk_app.dart';
import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/core/config/di/dependency_injection.dart';

void main() {
  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('app starts on onboarding and renders first content page', (
    WidgetTester tester,
  ) async {
    await setupGetIt(AppEnvironment.fromFlavor(AppFlavor.development));

    await tester.pumpWidget(const ElFulkApp());
    await tester.pump();

    // Wait for the logo page auto-advance (4s) and the page animation.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('عالم آمن يبدأ من هنا'), findsOneWidget);
  });
}
