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
  static const String resetPasswordScreen = '/reset-password';
  static const String addChildScreen = '/parent/add-child';
  static const String addNewChildScreen = '/parent/add-new-child';
  static const String parentHomeScreen = '/parent';
  static const String parentRequestsScreen = '/parent/requests';
  static const String childHomeScreen = '/child';
  static const String architectureScreen = '/architecture';
  static const String devHubScreen = '/dev-hub';
  static const String notificationsScreen = '/notifications';
  static const String parentKidsScreen = '/parent/kids';
  static const String appSettingsScreen = '/profile/settings';
  static const String accountSettingsScreen = '/profile/account';
  static const String editPersonalInfoScreen = '/profile/edit-info';
  static const String changePasswordScreen = '/profile/change-password';
  static const String contactUsScreen = '/profile/contact';
  static const String helpScreen = '/profile/help';
  static const String aboutScreen = '/profile/about';
  static const String privacyScreen = '/profile/privacy';
  static const String faqScreen = '/profile/faq';
  static const String languageScreen = '/profile/language';
  static const String appearanceScreen = '/profile/appearance';
  static const String linkedDevicesScreen = '/profile/devices';
  static const String controlCenterScreen = '/control';
  static const String timeHubScreen = '/control/time';
  static const String rulesHubScreen = '/control/rules';
  static const String contentHubScreen = '/content';
  static const String libraryScreen = '/content/library';
  static const String detailsScreen = '/content/details';
  static const String readerScreen = '/content/reader';

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
      path: resetPasswordScreen,
      label: 'Reset Password',
      category: RouteCategory.screen,
      description: 'Set a new password after a successful reset OTP.',
    ),
    RouteCatalogItem(
      path: addChildScreen,
      label: 'Add Child',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: addNewChildScreen,
      label: 'Add New Child',
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
    RouteCatalogItem(
      path: notificationsScreen,
      label: 'Notifications',
      category: RouteCategory.screen,
      description: 'Parent notifications: filters, groups and actions.',
    ),
    RouteCatalogItem(
      path: parentKidsScreen,
      label: 'My Kids (children list)',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: appSettingsScreen,
      label: 'App Settings',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: accountSettingsScreen,
      label: 'Account Settings',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: editPersonalInfoScreen,
      label: 'Edit Personal Info',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: changePasswordScreen,
      label: 'Change Password',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: contactUsScreen,
      label: 'Contact Us',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: helpScreen,
      label: 'Help & Support',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: faqScreen,
      label: 'FAQ',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: aboutScreen,
      label: 'About Us',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: privacyScreen,
      label: 'Privacy Policy',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: languageScreen,
      label: 'Language',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: appearanceScreen,
      label: 'Appearance',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: linkedDevicesScreen,
      label: 'Linked Devices',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: controlCenterScreen,
      label: 'Control Center',
      category: RouteCategory.screen,
      description: 'Activities dashboard (control tab root).',
    ),
    RouteCatalogItem(
      path: timeHubScreen,
      label: 'Time Management',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: rulesHubScreen,
      label: 'Rules Management',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: contentHubScreen,
      label: 'Content Hub',
      category: RouteCategory.screen,
    ),
    RouteCatalogItem(
      path: libraryScreen,
      label: 'Content Library (games)',
      category: RouteCategory.screen,
      description: 'Use ?type=games|stories|videos.',
      queryParameters: <String, String>{'type': 'games'},
    ),
    RouteCatalogItem(
      path: detailsScreen,
      label: 'Content Details (sample)',
      category: RouteCategory.screen,
      queryParameters: <String, String>{'id': 'g1'},
    ),
    RouteCatalogItem(
      path: readerScreen,
      label: 'Story Reader (sample)',
      category: RouteCategory.screen,
      queryParameters: <String, String>{'id': 's1'},
    ),
  ];
}
