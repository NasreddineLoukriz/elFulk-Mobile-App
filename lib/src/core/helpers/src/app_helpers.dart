import 'package:flutter/material.dart';

class AppHelpers {
  const AppHelpers._();

  static void hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.unfocus();
    }
  }

  static String orFallback(String? value, {String fallback = '--'}) {
    final String normalizedValue = value?.trim() ?? '';
    return normalizedValue.isEmpty ? fallback : normalizedValue;
  }

  static String extractErrorMessage(
    Object error, {
    String fallback = 'Something went wrong.',
  }) {
    final String message = error.toString().trim();
    return message.isEmpty ? fallback : message;
  }

  static void showAppSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final Color backgroundColor = isError
        ? Colors.red.shade700
        : Theme.of(context).colorScheme.primary;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }
}
