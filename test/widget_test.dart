import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/widgets/app_badge.dart';
import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/app_error_card.dart';
import 'package:elfulk/src/core/widgets/app_filter_chip.dart';
import 'package:elfulk/src/core/widgets/app_loading_view.dart';
import 'package:elfulk/src/core/widgets/custom_pin_keypad.dart';
import 'package:elfulk/src/core/widgets/empty_state.dart';
import 'package:elfulk/src/core/widgets/helpers/show_app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/parent_bottom_nav.dart';
import 'package:elfulk/src/core/widgets/parent_shell_scaffold.dart';
import 'package:elfulk/src/core/widgets/pin_display_row.dart';
import 'package:elfulk/src/core/widgets/section_header.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/otp_verification_screen.dart';

void main() {
  testWidgets('otp screen renders reusable pin widgets and updates input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) => const MaterialApp(
          home: OtpVerificationScreen(
            type: OtpVerificationType.emailVerification,
          ),
        ),
      ),
    );

    expect(find.byType(PinDisplayRow), findsOneWidget);
    expect(find.byType(CustomPinKeypad), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('otp-keypad-1')));
    await tester.tap(find.byKey(const ValueKey('otp-keypad-2')));
    await tester.tap(find.byKey(const ValueKey('otp-keypad-3')));
    await tester.pump();

    expect(
      tester.widget<PinDisplayRow>(find.byType(PinDisplayRow)).value,
      '123',
    );

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('otp-keypad-delete')));
    await tester.pump();

    expect(
      tester.widget<PinDisplayRow>(find.byType(PinDisplayRow)).value,
      '12',
    );

    await tester.tap(find.byKey(const ValueKey('otp-keypad-clear')));
    await tester.pump();

    expect(
      tester.widget<PinDisplayRow>(find.byType(PinDisplayRow)).value,
      '',
    );
  });

  testWidgets(
    'confirmation dialog opens, slide commits, cancel dismisses',
    (WidgetTester tester) async {
      const AppConfirmationConfig config = AppConfirmationConfig(
        title: 'هل انت متأكد من حذف الحساب الشخصي ؟',
        message: 'body',
        icon: Icon(Icons.delete),
        primaryActionType: AppConfirmationPrimaryActionType.destructive,
        primaryActionLabel: 'حذف حسابي',
        secondaryActionLabel: 'إلغاء',
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: TextButton(
                  onPressed: () => showAppConfirmationDialog(
                    context: context,
                    config: config,
                  ),
                  child: const Text('open-dialog'),
                ),
              ),
            ),
          ),
        ),
      );

      // Opens with both buttons.
      await tester.tap(find.text('open-dialog'));
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsOneWidget);
      expect(
        find.byKey(const ValueKey('slide-to-confirm-thumb')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('app-confirmation-secondary')),
        findsOneWidget,
      );

      // Full slide commits and closes the dialog.
      await tester.drag(
        find.byKey(const ValueKey('slide-to-confirm-thumb')),
        const Offset(500, 0),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsNothing);

      // Cancel dismisses the dialog.
      await tester.tap(find.text('open-dialog'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const ValueKey('app-confirmation-secondary')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsNothing);
    },
  );

  testWidgets(
    'forced rtl slide commits right-to-left under ltr ambient',
    (WidgetTester tester) async {
      const AppConfirmationConfig config = AppConfirmationConfig(
        title: 't',
        message: 'm',
        icon: Icon(Icons.delete),
        primaryActionType: AppConfirmationPrimaryActionType.destructive,
        primaryActionLabel: 'label',
        secondaryActionLabel: 'cancel',
        slideTextDirection: TextDirection.rtl,
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: TextButton(
                  onPressed: () => showAppConfirmationDialog(
                    context: context,
                    config: config,
                  ),
                  child: const Text('open-dialog'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open-dialog'));
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsOneWidget);

      // Right-to-left drag commits and closes the dialog.
      await tester.drag(
        find.byKey(const ValueKey('slide-to-confirm-thumb')),
        const Offset(-500, 0),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsNothing);
    },
  );

  testWidgets(
    'settings list tile variants render subtitle, switch, tap',
    (WidgetTester tester) async {
      bool switchValue = true;
      bool tapped = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) => Column(
                  children: [
                    SettingsListTile(
                      title: 'إشعارات التنبيهات الحرجة.',
                      subtitle: 'تنبيهك فورًا عند أي محاولة لتجاوز القيود.',
                      leading: const Icon(Icons.warning_amber_rounded),
                      trailing: SettingsTileTrailing.switch_(
                        value: switchValue,
                        onChanged: (bool v) =>
                            setState(() => switchValue = v),
                      ),
                      onTap: () => tapped = true,
                    ),
                    const SettingsListTile(
                      title: 'تغيير اللغة',
                      trailing: SettingsTileTrailing.chevron(),
                    ),
                    const SettingsListTile(
                      title: 'اللغة',
                      trailing: SettingsTileTrailing.value('العربية'),
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Titles, description, trailing controls and dividers render:
      // one full-bleed mid divider under the described row, two inset
      // bottom dividers.
      expect(find.text('إشعارات التنبيهات الحرجة.'), findsOneWidget);
      expect(find.text('تنبيهك فورًا عند أي محاولة لتجاوز القيود.'),
          findsOneWidget);
      expect(find.byKey(const ValueKey('settings-tile-switch')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('settings-tile-chevron')),
          findsOneWidget);
      expect(find.text('العربية'), findsOneWidget);
      expect(find.byKey(const ValueKey('settings-tile-divider-mid')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('settings-tile-divider')),
          findsNWidgets(2));

      // Tapping the description does NOT fire onTap (outside InkWell).
      await tester.tap(find.text('تنبيهك فورًا عند أي محاولة لتجاوز القيود.'));
      await tester.pump();
      expect(tapped, isFalse);

      // Toggling the switch flips the parent-owned value.
      await tester.tap(find.byKey(const ValueKey('settings-tile-switch')));
      await tester.pumpAndSettle();
      expect(switchValue, isFalse);
      expect(
        tester
            .widget<Switch>(
                find.byKey(const ValueKey('settings-tile-switch')))
            .value,
        isFalse,
      );

      // Tapping the title row fires onTap.
      await tester.tap(find.text('إشعارات التنبيهات الحرجة.'));
      await tester.pump();
      expect(tapped, isTrue);
    },
  );

  testWidgets(
    'settings tile renders its own card background',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: SettingsListTile(
                title: 't',
                backgroundColor: Colors.red,
                showDivider: false,
              ),
            ),
          ),
        ),
      );

      final bool hasRedCard =
          tester.widgetList<Material>(find.byType(Material)).any(
                (Material m) => m.color == Colors.red,
              );
      expect(hasRedCard, isTrue);
    },
  );

  testWidgets(
    'P0 foundation widgets render and interact',
    (WidgetTester tester) async {
      int tappedNav = -1;
      bool chipTapped = false;
      bool retried = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ParentBottomNav(
                      currentIndex: 0,
                      onTap: (int i) => tappedNav = i,
                    ),
                    const SectionHeader(title: 'كل الإشعارات'),
                    AppFilterChip(
                      label: 'الكل',
                      selected: false,
                      onSelected: () => chipTapped = true,
                    ),
                    const AppBadge(label: '01'),
                    const EmptyState(
                      icon: Icons.notifications_none,
                      title: 'لا توجد إشعارات',
                      message: 'ستظهر هنا عند وصول جديد.',
                    ),
                    AppErrorCard(
                      message: 'تعذر التحميل.',
                      onRetry: () => retried = true,
                    ),
                    const AppLoadingView(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('حسابي'), findsOneWidget);
      expect(find.text('مركز التحكم'), findsOneWidget);
      expect(find.text('النشاط'), findsOneWidget);
      expect(find.text('الرئيسية'), findsOneWidget);
      expect(find.text('كل الإشعارات'), findsOneWidget);
      expect(find.text('الكل'), findsOneWidget);
      expect(find.text('01'), findsOneWidget);
      expect(find.text('لا توجد إشعارات'), findsOneWidget);
      expect(find.text('تعذر التحميل.'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.tap(find.text('النشاط'));
      await tester.pump();
      expect(tappedNav, 2);

      await tester.tap(find.text('الكل'));
      await tester.pump();
      expect(chipTapped, isTrue);

      await tester.ensureVisible(find.text('إعادة المحاولة'));
      await tester.tap(find.text('إعادة المحاولة'));
      await tester.pump();
      expect(retried, isTrue);
    },
  );

  testWidgets(
    'parent shell switches branches and preserves state',
    (WidgetTester tester) async {
      Widget branch(String name, {bool withField = false}) {
        return Scaffold(
          body: Center(
            child: withField
                ? TextField(key: ValueKey('shell-field-$name'))
                : Text('branch-$name'),
          ),
        );
      }

      final GoRouter router = GoRouter(
        initialLocation: '/a',
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, shell) =>
                ParentShellScaffold(navigationShell: shell),
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(path: '/a', builder: (c, s) => branch('a', withField: true)),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(path: '/b', builder: (c, s) => branch('b')),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(path: '/c', builder: (c, s) => branch('c')),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(path: '/d', builder: (c, s) => branch('d')),
                ],
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) =>
              MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('shell-field-a')), findsOneWidget);
      expect(find.byType(ParentBottomNav), findsOneWidget);

      await tester.enterText(
          find.byKey(const ValueKey('shell-field-a')), 'hello');
      await tester.pump();

      await tester.tap(find.text('النشاط'));
      await tester.pumpAndSettle();
      expect(find.text('branch-c'), findsOneWidget);

      await tester.tap(find.text('حسابي'));
      await tester.pumpAndSettle();
      // State preserved: the text entered in branch A is still displayed.
      expect(find.text('hello'), findsOneWidget);
      expect(find.byKey(const ValueKey('shell-field-a')), findsOneWidget);
    },
  );
}
