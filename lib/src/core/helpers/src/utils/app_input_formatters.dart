import 'package:flutter/services.dart';

class AppInputFormatters {
  const AppInputFormatters._();

  static List<TextInputFormatter> lowercaseAlphaNumeric() =>
      <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        TextInputFormatter.withFunction((
          TextEditingValue oldValue,
          TextEditingValue newValue,
        ) {
          final String normalizedValue = newValue.text.toLowerCase();

          if (normalizedValue == newValue.text) {
            return newValue;
          }

          return newValue.copyWith(
            text: normalizedValue,
            composing: TextRange.empty,
          );
        }),
      ];

  static List<TextInputFormatter> decimalNumber({int decimalRange = 2}) =>
      <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp('^\\\\d*\\\\.?\\\\d{0,$decimalRange}'),
        ),
      ];
}
