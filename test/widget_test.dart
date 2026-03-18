import 'package:flutter_test/flutter_test.dart';

import 'package:elfulk/src/core/app/elfulk_app.dart';
import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/core/config/di/dependency_injection.dart';

void main() {
  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('app, parent, and child example entry points render on home', (
    WidgetTester tester,
  ) async {
    await setupGetIt(AppEnvironment.fromFlavor(AppFlavor.development));

    await tester.pumpWidget(const ElFulkApp());
    await tester.pumpAndSettle();

    expect(find.text('ElFulk App Features'), findsOneWidget);
    expect(find.text('Open parent example'), findsOneWidget);
    expect(find.text('Open parent Bloc example'), findsOneWidget);
    expect(find.text('Open child example'), findsOneWidget);
  });
}
