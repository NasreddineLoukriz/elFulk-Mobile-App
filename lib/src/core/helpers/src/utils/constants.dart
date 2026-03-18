import 'package:flutter/material.dart';

class AppConstants {
  const AppConstants._();

  static const Size designSize = Size(430, 731);
  static const Duration shortAnimationDuration = Duration(milliseconds: 250);
  static const String emptyPlaceholder = '--';
}

class SharedPrefKeys {
  const SharedPrefKeys._();

  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String locale = 'locale';
  static const String appMode = 'app_mode';
  static const String activeProfileId = 'active_profile_id';
}
