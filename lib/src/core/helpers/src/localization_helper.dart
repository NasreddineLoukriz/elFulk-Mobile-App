import 'package:flutter/widgets.dart';

class LocalizationHelper {
  const LocalizationHelper._();

  static const String path = 'assets/translations';
  static const Locale fallbackLocale = Locale('en');
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  static Locale? parseLocale(String? localeString) {
    if (localeString == null || localeString.trim().isEmpty) {
      return null;
    }

    final List<String> parts = localeString.split('_');
    if (parts.isEmpty || parts.first.trim().isEmpty) {
      return null;
    }

    if (parts.length == 1) {
      return Locale(parts.first);
    }

    return Locale(parts.first, parts[1]);
  }

  static String localeToStorageValue(Locale locale) {
    final String countryCode = locale.countryCode?.trim() ?? '';
    if (countryCode.isEmpty) {
      return locale.languageCode;
    }

    return '${locale.languageCode}_$countryCode';
  }
}
