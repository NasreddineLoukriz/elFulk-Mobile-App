import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/networking/app/app_api_service.dart';
import 'package:elfulk/src/core/networking/helper/dio_factory.dart';
import 'package:elfulk/src/core/theme/app_theme.dart';
import 'package:elfulk/src/features/app_features/auth/data/repos/auth_repository.dart';
import 'package:elfulk/src/features/app_features/auth/logic/cubit/auth_cubit.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/forget_password_screen.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/login_screen.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/otp_verification_screen.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/register_screen.dart';
import 'package:elfulk/src/features/app_features/auth/ui/screens/reset_password_screen.dart';

/// تطبيق مصغّر يربط شاشات المصادقة بمسار رئيسية وهمي للتحقق من التنقّل.
Widget _buildAuthApp({
  required AuthCubit cubit,
  required String initialLocation,
}) {
  final GoRouter router = GoRouter(
    initialLocation: initialLocation,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.homeScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const Scaffold(body: Center(child: Text('HOME_STUB'))),
      ),
      GoRoute(
        path: Routes.loginScreen,
        builder: (BuildContext context, GoRouterState state) =>
            BlocProvider<AuthCubit>.value(
              value: cubit,
              child: const LoginScreen(),
            ),
      ),
      GoRoute(
        path: Routes.registerScreen,
        builder: (BuildContext context, GoRouterState state) =>
            BlocProvider<AuthCubit>.value(
              value: cubit,
              child: const RegisterScreen(),
            ),
      ),
      GoRoute(
        path: Routes.otpVerificationScreen,
        builder: (BuildContext context, GoRouterState state) {
          final bool isEmail =
              state.uri.queryParameters['type'] == 'email';
          return OtpVerificationScreen(
            type: isEmail
                ? OtpVerificationType.emailVerification
                : OtpVerificationType.passwordReset,
          );
        },
      ),
      GoRoute(
        path: Routes.forgetPasswordScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: Routes.resetPasswordScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const ResetPasswordScreen(),
      ),
    ],
  );

  return ScreenUtilInit(
    designSize: const Size(390, 844),
    minTextAdapt: true,
    builder: (BuildContext context, Widget? child) => MaterialApp.router(
      locale: const Locale('ar'),
      supportedLocales: const <Locale>[Locale('ar')],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: buildLightTheme(),
      routerConfig: router,
    ),
  );
}

AuthCubit _buildCubit() => AuthCubit(
  AuthRepository(
    AppApiService(DioFactory.getDio(), baseUrl: 'https://dummy.local'),
  ),
);

Future<void> _pumpAuthApp(
  WidgetTester tester, {
  required AuthCubit cubit,
  required String initialLocation,
}) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    _buildAuthApp(cubit: cubit, initialLocation: initialLocation),
  );
  await tester.pump();
}

/// يمرّر الشاشة حتى يظهر العنصر ثم يضغطه (بعض الأزرار أسفل الشاشة).
Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await tester.pump();
}

void main() {
  testWidgets('login with dummy auth navigates to home', (
    WidgetTester tester,
  ) async {
    final AuthCubit cubit = _buildCubit();
    addTearDown(cubit.close);

    await _pumpAuthApp(
      tester,
      cubit: cubit,
      initialLocation: Routes.loginScreen,
    );

    await tester.enterText(
      find.byKey(const ValueKey<String>('login-email')),
      'nas@elfulk.ai',
    );
    await tester.enterText(
      find.byKey(const ValueKey<String>('login-password')),
      'secret123',
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('login-submit')),
    );

    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('HOME_STUB'), findsOneWidget);
    expect(cubit.state, isA<AuthAuthenticated>());
  });

  testWidgets('login rejects an invalid email without navigating', (
    WidgetTester tester,
  ) async {
    final AuthCubit cubit = _buildCubit();
    addTearDown(cubit.close);

    await _pumpAuthApp(
      tester,
      cubit: cubit,
      initialLocation: Routes.loginScreen,
    );

    await tester.enterText(
      find.byKey(const ValueKey<String>('login-email')),
      'not-an-email',
    );
    await tester.enterText(
      find.byKey(const ValueKey<String>('login-password')),
      'secret123',
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('login-submit')),
    );

    expect(find.text('أدخل بريدًا إلكترونيًا صحيحًا'), findsOneWidget);
    expect(find.text('HOME_STUB'), findsNothing);
  });

  testWidgets('register sends an email OTP then completes login', (
    WidgetTester tester,
  ) async {
    final AuthCubit cubit = _buildCubit();
    addTearDown(cubit.close);

    await _pumpAuthApp(
      tester,
      cubit: cubit,
      initialLocation: Routes.registerScreen,
    );

    await tester.enterText(
      find.byKey(const ValueKey<String>('register-name')),
      'أحمد علي',
    );
    await tester.enterText(
      find.byKey(const ValueKey<String>('register-email')),
      'new@elfulk.ai',
    );
    await tester.enterText(
      find.byKey(const ValueKey<String>('register-password')),
      'secret123',
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('register-terms')),
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('register-submit')),
    );

    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('تفقد بريدك الإلكتروني.'), findsOneWidget);

    for (final String digit in <String>['1', '2', '3', '4', '5']) {
      await _tapVisible(
        tester,
        find.byKey(ValueKey<String>('otp-keypad-$digit')),
      );
    }
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('otp-submit')),
    );
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('HOME_STUB'), findsOneWidget);
  });

  testWidgets('wrong OTP shows an error and stays on the screen', (
    WidgetTester tester,
  ) async {
    final AuthCubit cubit = _buildCubit();
    addTearDown(cubit.close);

    await _pumpAuthApp(
      tester,
      cubit: cubit,
      initialLocation: '${Routes.otpVerificationScreen}?type=email',
    );

    for (int i = 0; i < 5; i++) {
      await _tapVisible(
        tester,
        find.byKey(const ValueKey<String>('otp-keypad-1')),
      );
    }
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('otp-submit')),
    );

    expect(find.text('الرمز غير صحيح. حاول مرة أخرى.'), findsOneWidget);
    expect(find.text('HOME_STUB'), findsNothing);
    expect(find.byType(OtpVerificationScreen), findsOneWidget);
  });

  testWidgets('forgot password opens the reset OTP flow', (
    WidgetTester tester,
  ) async {
    final AuthCubit cubit = _buildCubit();
    addTearDown(cubit.close);

    await _pumpAuthApp(
      tester,
      cubit: cubit,
      initialLocation: Routes.forgetPasswordScreen,
    );

    await tester.enterText(
      find.byKey(const ValueKey<String>('forgot-email')),
      'nas@elfulk.ai',
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('forgot-submit')),
    );
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('أرسلنا لك رمز التحقق.'), findsOneWidget);
    expect(
      find.text('إعادة تعيين كلمة مرور جديدة'),
      findsOneWidget,
    );
  });

  testWidgets('reset OTP opens the new password screen and returns to login', (
    WidgetTester tester,
  ) async {
    final AuthCubit cubit = _buildCubit();
    addTearDown(cubit.close);

    await _pumpAuthApp(
      tester,
      cubit: cubit,
      initialLocation: '${Routes.otpVerificationScreen}?type=reset',
    );

    for (final String digit in <String>['1', '2', '3', '4', '5']) {
      await _tapVisible(
        tester,
        find.byKey(ValueKey<String>('otp-keypad-$digit')),
      );
    }
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('otp-submit')),
    );
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(ResetPasswordScreen), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey<String>('reset-password')),
      'newsecret123',
    );
    await tester.enterText(
      find.byKey(const ValueKey<String>('reset-confirm')),
      'newsecret123',
    );
    await _tapVisible(
      tester,
      find.byKey(const ValueKey<String>('reset-submit')),
    );
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
