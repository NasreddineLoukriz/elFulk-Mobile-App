enum RouteCategory { screen, dialog, bottomSheet }

class RouteCatalogItem {
  final String path;
  final String label;
  final RouteCategory category;
  final String? description;
  final Map<String, String>? queryParameters;

  const RouteCatalogItem({
    required this.path,
    required this.label,
    required this.category,
    this.description,
    this.queryParameters,
  });
}

class Routes {
  static const String onboardingScreen = '/onboarding'; // ✅ ajouter
  static const String homeScreen = '/';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String otpVerificationScreen = '/otp-verification';
  static const String forgetPasswordScreen = '/forget-password';
  static const String parentHomeScreen = '/parent';
  static const String parentRequestsScreen = '/parent/requests';
  static const String childHomeScreen = '/child';
  static const String architectureScreen = '/architecture';
  static const String devHubScreen = '/dev-hub';

  /// Auto-discoverable catalog of all app routes used by the dev hub.
  ///
  /// When you add a new route, register it here so it appears in the
  /// developer catalog automatically.
  static const List<RouteCatalogItem> catalog = <RouteCatalogItem>[
    RouteCatalogItem(
      path: onboardingScreen,
      label: 'Onboarding',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: homeScreen,
      label: 'Home',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: loginScreen,
      label: 'Login',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: registerScreen,
      label: 'Register',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: otpVerificationScreen,
      label: 'OTP Verification (email)',
      category: RouteCategory.screen,
      description: 'OTP flow in email-verification mode.',
      queryParameters: <String, String>{'type': 'email'},
    ),
    RouteCatalogItem(
      path: otpVerificationScreen,
      label: 'OTP Verification (password reset)',
      category: RouteCategory.screen,
      description: 'OTP flow in password-reset mode.',
      queryParameters: <String, String>{'type': 'password'},
    ),
    RouteCatalogItem(
      path: forgetPasswordScreen,
      label: 'Forget Password',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: parentHomeScreen,
      label: 'Parent Home',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: parentRequestsScreen,
      label: 'Parent Requests',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: childHomeScreen,
      label: 'Child Home',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: architectureScreen,
      label: 'Architecture Overview',
      category: RouteCategory.screen,
    ),
  ];
}
