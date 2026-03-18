class AppNumbersFormatter {
  const AppNumbersFormatter._();

  static String formatNumber(num value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k';
    }

    return value.toStringAsFixed(0);
  }

  static String formatPrice<T>(T value) {
    if (value is num) {
      return _toIntThenString(value);
    }

    if (value is String) {
      try {
        return _toIntThenString(num.parse(value));
      } catch (_) {
        return value;
      }
    }

    throw ArgumentError('Unsupported type: ${value.runtimeType}');
  }

  static String _toIntThenString(num price) => price.toInt().toString();
}
