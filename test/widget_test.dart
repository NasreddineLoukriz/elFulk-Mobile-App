import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:elfulk/src/core/widgets/app_badge.dart';
import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';
import 'package:elfulk/src/core/widgets/app_sheets.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/account_settings_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/appearance_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/change_password_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/contact_us_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/edit_personal_info_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/language_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/linked_devices_screen.dart';
import 'package:elfulk/src/features/parent_features/profile/ui/screens/profile_screen.dart';
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
import 'package:elfulk/src/features/app_features/home/data/repos/home_dashboard_repository.dart';
import 'package:elfulk/src/features/app_features/home/logic/dashboard_cubit/home_dashboard_cubit.dart';
import 'package:elfulk/src/features/app_features/home/ui/screens/home_screen.dart';
import 'package:elfulk/src/features/app_features/notifications/data/repos/notifications_repository.dart';
import 'package:elfulk/src/features/app_features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:elfulk/src/features/app_features/notifications/ui/screens/notifications_screen.dart';
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

    expect(tester.widget<PinDisplayRow>(find.byType(PinDisplayRow)).value, '');
  });

  testWidgets('confirmation dialog opens, slide commits, cancel dismisses', (
    WidgetTester tester,
  ) async {
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
                onPressed: () =>
                    showAppConfirmationDialog(context: context, config: config),
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
    await tester.tap(find.byKey(const ValueKey('app-confirmation-secondary')));
    await tester.pumpAndSettle();
    expect(find.byType(AppConfirmationDialog), findsNothing);
  });

  testWidgets('forced rtl slide commits right-to-left under ltr ambient', (
    WidgetTester tester,
  ) async {
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
                onPressed: () =>
                    showAppConfirmationDialog(context: context, config: config),
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
  });

  testWidgets('settings list tile variants render subtitle, switch, tap', (
    WidgetTester tester,
  ) async {
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
                      onChanged: (bool v) => setState(() => switchValue = v),
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
    expect(
      find.text('تنبيهك فورًا عند أي محاولة لتجاوز القيود.'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('settings-tile-switch')), findsOneWidget);
    expect(find.byKey(const ValueKey('settings-tile-chevron')), findsOneWidget);
    expect(find.text('العربية'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('settings-tile-divider-mid')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('settings-tile-divider')),
      findsNWidgets(2),
    );

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
          .widget<Switch>(find.byKey(const ValueKey('settings-tile-switch')))
          .value,
      isFalse,
    );

    // Tapping the title row fires onTap.
    await tester.tap(find.text('إشعارات التنبيهات الحرجة.'));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('settings tile renders its own card background', (
    WidgetTester tester,
  ) async {
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

    final bool hasRedCard = tester
        .widgetList<Material>(find.byType(Material))
        .any((Material m) => m.color == Colors.red);
    expect(hasRedCard, isTrue);
  });

  testWidgets('P0 foundation widgets render and interact', (
    WidgetTester tester,
  ) async {
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
      expect(tappedNav, 1);

    await tester.tap(find.text('الكل'));
    await tester.pump();
    expect(chipTapped, isTrue);

    await tester.ensureVisible(find.text('إعادة المحاولة'));
    await tester.tap(find.text('إعادة المحاولة'));
    await tester.pump();
    expect(retried, isTrue);
  });

  testWidgets('parent shell switches branches and preserves state', (
    WidgetTester tester,
  ) async {
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
                GoRoute(
                  path: '/a',
                  builder: (c, s) => branch('a', withField: true),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [GoRoute(path: '/b', builder: (c, s) => branch('b'))],
            ),
            StatefulShellBranch(
              routes: [GoRoute(path: '/c', builder: (c, s) => branch('c'))],
            ),
            StatefulShellBranch(
              routes: [GoRoute(path: '/d', builder: (c, s) => branch('d'))],
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('shell-field-a')), findsOneWidget);
    expect(find.byType(ParentBottomNav), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('shell-field-a')),
      'hello',
    );
    await tester.pump();

      await tester.tap(find.text('مركز التحكم'));
      await tester.pumpAndSettle();
      expect(find.text('branch-c'), findsOneWidget);

      await tester.tap(find.text('الرئيسية'));
      await tester.pumpAndSettle();
    // State preserved: the text entered in branch A is still displayed.
    expect(find.text('hello'), findsOneWidget);
    expect(find.byKey(const ValueKey('shell-field-a')), findsOneWidget);
  });

  testWidgets('home dashboard renders tabs, upsell and children', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<HomeDashboardCubit>(
                  create: (_) =>
                      HomeDashboardCubit(const HomeDashboardRepository())
                        ..load(),
                ),
                BlocProvider<NotificationsCubit>(
                  create: (_) =>
                      NotificationsCubit(const NotificationsRepository())
                        ..load(),
                ),
              ],
              child: const HomeScreen(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Phone upsell dialog shows once per session.
    expect(find.byType(AppConfirmationDialog), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('app-confirmation-secondary')));
    await tester.pumpAndSettle();
    expect(find.byType(AppConfirmationDialog), findsNothing);

    // Dashboard tab: greeting, children, activity, library, device.
    expect(find.text('طاب يومك اسم المستخدم 👋'), findsOneWidget);
    expect(find.text('أنس مالك'), findsWidgets);
    expect(find.text('بعض بيانات النشاط داخل المنصة بأطفالك'), findsOneWidget);

    // Alerts tab shows notification cards.
    await tester.tap(find.text('الاشعارات'));
    await tester.pumpAndSettle();
    expect(find.text('تجاوز الحد الصحي الموصى به'), findsOneWidget);

    // Children tab shows cards plus the dashed add card.
    await tester.tap(find.text('اطفالي'));
    await tester.pumpAndSettle();
    expect(find.text('ليلى مالك'), findsOneWidget);
    expect(find.byKey(const ValueKey('add-child-dashed-card')), findsOneWidget);
  });

  testWidgets('notifications screen filters and dismisses', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: BlocProvider<NotificationsCubit>(
              create: (_) =>
                  NotificationsCubit(const NotificationsRepository())..load(),
              child: const NotificationsScreen(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('الإشعارات'), findsOneWidget);
    expect(find.text('تجاوز الحد الصحي الموصى به'), findsOneWidget);

    // Filter to time category only.
    await tester.tap(find.widgetWithText(AppFilterChip, 'الوقت'));
    await tester.pumpAndSettle();
    expect(find.text('الاستخدام بعد وقت النوم'), findsOneWidget);
    expect(find.text('تجاوز الحد الصحي الموصى به'), findsNothing);

    // Back to all, then dismiss the first card by its X button.
    await tester.tap(find.text('كل الإشعارات'));
    await tester.pumpAndSettle();
    expect(find.text('تجاوز الحد الصحي الموصى به'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('notification-dismiss')).first);
    await tester.pumpAndSettle();
    expect(find.text('تجاوز الحد الصحي الموصى به'), findsNothing);
    // Other cards stay.
    expect(find.text('الاستخدام بعد وقت النوم'), findsOneWidget);
  });

  testWidgets(
    'profile renders header and navigates to kids',
    (WidgetTester tester) async {
      final GoRouter router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/parent/kids',
            builder: (context, state) => const Text('kids-stub'),
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

      expect(find.text('الحساب الشخصي'), findsOneWidget);
      expect(find.text('اسم المستخدم'), findsOneWidget);
      expect(find.text('example123@gmail.com'), findsOneWidget);

      await tester.ensureVisible(find.text('أطفالي'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('أطفالي'));
      await tester.pumpAndSettle();
      expect(find.text('kids-stub'), findsOneWidget);
    },
  );

  testWidgets(
    'pin entry sheet returns the typed code',
    (WidgetTester tester) async {
      String? pinResult;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () async {
                    pinResult = await showPinEntrySheet(
                      context: context,
                      title: 'أدخل الرمز',
                      confirmLabel: 'التالي',
                    );
                  },
                  child: const Text('open-pin'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open-pin'));
      await tester.pumpAndSettle();

      for (final String digit in ['1', '2', '3', '4', '5']) {
        await tester.tap(find.byKey(ValueKey('otp-keypad-$digit')));
        await tester.pump();
      }
      await tester.tap(find.text('التالي'));
      await tester.pumpAndSettle();
      expect(pinResult, '12345');
    },
  );

  testWidgets(
    'delete account chains two slide dialogs then confirms',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Scaffold(body: AccountSettingsScreen()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('حذف الحساب'));
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsOneWidget);

      // The tall dialog may need scrolling to reveal the thumb.
      await tester.ensureVisible(
        find.byKey(const ValueKey('slide-to-confirm-thumb')),
      );
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const ValueKey('slide-to-confirm-thumb')),
        const Offset(-500, 0),
      );
      await tester.pumpAndSettle();
      expect(find.text('تحذير نهائي قبل الحذف'), findsOneWidget);

      // The tall dialog may need scrolling to reveal the thumb.
      await tester.ensureVisible(
        find.byKey(const ValueKey('slide-to-confirm-thumb')),
      );
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const ValueKey('slide-to-confirm-thumb')),
        const Offset(-500, 0),
      );
      await tester.pumpAndSettle();
      expect(find.text('تم إرسال طلب حذف الحساب.'), findsOneWidget);
    },
  );

  testWidgets(
    'contact form validates then shows success state',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Scaffold(body: ContactUsScreen()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('إرسال'));
      await tester.pump();
      expect(find.text('إرسال'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'أحمد');
      await tester.enterText(
          find.byType(TextField).at(1), 'ahmed@elfulk.app');
      await tester.enterText(find.byType(TextField).at(2), 'مرحباً بالفريق.');
      await tester.tap(find.byKey(const ValueKey('check-row')));
      await tester.pump();
      await tester.tap(find.text('إرسال'));
      await tester.pump();
      expect(find.text('تم الإرسال بنجاح ✓'), findsOneWidget);
    },
  );

  testWidgets(
    'linked devices pause toggles status and lock opens dialog',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Scaffold(body: LinkedDevicesScreen()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('نشط حاليا'), findsNWidgets(2));
      await tester.tap(
        find.byKey(const ValueKey('device-card-pause')).first,
      );
      await tester.pump();
      expect(find.text('موقوف مؤقتاً'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('device-card-lock')).first,
      );
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsOneWidget);
      await tester.tap(
        find.byKey(const ValueKey('app-confirmation-secondary')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AppConfirmationDialog), findsNothing);
    },
  );

  testWidgets(
    'appearance toggles the real theme cubit',
    (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final ThemeCubit cubit = ThemeCubit();

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: BlocProvider<ThemeCubit>.value(
              value: cubit,
              child: const Scaffold(body: AppearanceScreen()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('داكن'));
      await tester.pumpAndSettle();
      expect(cubit.state.mode, ThemeMode.dark);
    },
  );

  testWidgets(
    'language selection persists to storage',
    (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Scaffold(body: LanguageScreen()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      final SharedPreferences prefs =
          await SharedPreferences.getInstance();
      expect(prefs.getString('locale'), 'en');
    },
  );

  testWidgets(
    'edit info validates then saves and pops',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Scaffold(body: EditPersonalInfoScreen()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('حفظ التعديلات'));
      await tester.pump();
      expect(find.text('حفظ التعديلات'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'nasreddine');
      await tester.enterText(find.byType(TextField).at(1), 'loukriz');
      await tester.enterText(
          find.byType(TextField).at(2), 'nas@elfulk.app');
      await tester.enterText(find.byType(TextField).at(3), '0555555555');
      await tester.ensureVisible(find.byKey(const ValueKey('check-row')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('check-row')));
      await tester.pump();
      await tester.ensureVisible(find.text('حفظ التعديلات'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('حفظ التعديلات'));
      await tester.pumpAndSettle();
      expect(find.text('تم حفظ البيانات بنجاح.'), findsOneWidget);
      // Drain the feedback delay, then the screen pops.
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text('حفظ التعديلات'), findsNothing);
    },
  );

  testWidgets(
    'change password rejects mismatch then confirms match',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Scaffold(body: ChangePasswordScreen()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'oldpass1');
      await tester.enterText(find.byType(TextField).at(1), 'newpass1');
      await tester.enterText(find.byType(TextField).at(2), 'different');
      await tester.ensureVisible(find.text('حفظ التعديلات'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('حفظ التعديلات'));
      await tester.pumpAndSettle();
      expect(find.text('تم تغيير كلمة المرور بنجاح.'), findsNothing);

      await tester.enterText(find.byType(TextField).at(2), 'newpass1');
      await tester.tap(find.text('حفظ التعديلات'));
      await tester.pumpAndSettle();
      expect(find.text('تم تغيير كلمة المرور بنجاح.'), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    },
  );
}
