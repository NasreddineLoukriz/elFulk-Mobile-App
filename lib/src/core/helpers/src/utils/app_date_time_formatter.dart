import 'package:intl/intl.dart';

class AppDateTimeFormatter {
  const AppDateTimeFormatter._();

  static DateTime normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static String formatDateForApi(DateTime date) {
    final DateTime normalizedDate = normalizeDate(date);
    return '${normalizedDate.year}-${normalizedDate.month}-${normalizedDate.day}';
  }

  static String? formatDateForApiOrNull(DateTime? date) {
    if (date == null) {
      return null;
    }

    return formatDateForApi(date);
  }

  static String getCurrentDate(DateTime date, [String? locale]) =>
      DateFormat('EEEE d', locale).format(date) +
      DateFormat(', MMM', locale).format(date);

  static String formatApiDate(
    String dateStr,
    String locale, {
    bool indexOnly = false,
  }) {
    try {
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateStr)) {
        final DateTime dateTime = DateTime.parse(dateStr);

        if (indexOnly) {
          return DateFormat('EEEE', locale).format(dateTime)[0].toUpperCase();
        }

        return DateFormat('MMM d', locale).format(dateTime);
      }

      final DateTime dateTime = DateFormat('MMMM yyyy').parse(dateStr);

      if (indexOnly) {
        return dateTime.month.toString();
      }

      final String monthYear = DateFormat('MMMM yyyy', locale).format(dateTime);
      if (monthYear == dateStr) {
        return DateFormat('MMMM', locale).format(dateTime);
      }

      return DateFormat('MMM yyyy', locale).format(dateTime).split(' ').first;
    } catch (_) {
      return dateStr;
    }
  }

  static String formatIsoToReadableDate(String isoDateStr, [String? locale]) {
    try {
      final DateTime dateTime = DateTime.parse(isoDateStr).toLocal();
      return DateFormat('MMMM dd, yyyy', locale).format(dateTime);
    } catch (_) {
      return isoDateStr;
    }
  }

  static bool areDatesOnSameDay(String isoDateStr1, String isoDateStr2) {
    try {
      final DateTime date1 = DateTime.parse(isoDateStr1);
      final DateTime date2 = DateTime.parse(isoDateStr2);

      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    } catch (_) {
      return false;
    }
  }

  static bool isToday(String date) {
    try {
      final DateTime today = DateTime.now();
      final DateTime parsedDate = DateTime.parse(date);

      return today.year == parsedDate.year &&
          today.month == parsedDate.month &&
          today.day == parsedDate.day;
    } catch (_) {
      return false;
    }
  }

  static String formatIsoToDateWithDayAndHour(
    String isoDateStr, [
    String? locale,
  ]) {
    try {
      final DateTime dateTime = DateTime.parse(isoDateStr).toLocal();
      final String formattedDate = DateFormat('MMM d', locale).format(dateTime);
      final String formattedTime = locale == 'ar'
          ? DateFormat('HH:mm', locale).format(dateTime)
          : DateFormat('h:mm a', locale).format(dateTime);

      return locale == 'ar'
          ? '$formattedDate $formattedTime'
          : '$formattedDate at $formattedTime';
    } catch (_) {
      return isoDateStr;
    }
  }

  static String formatIsoToHourAndMinute(String isoDateStr, [String? locale]) {
    try {
      final DateTime dateTime = DateTime.parse(isoDateStr).toLocal();
      return DateFormat('HH:mm', locale).format(dateTime);
    } catch (_) {
      return isoDateStr;
    }
  }

  static String formatIsoToFullDate(String isoDateStr, [String? locale]) {
    try {
      final DateTime dateTime = DateTime.parse(isoDateStr).toLocal();
      return DateFormat('MMM dd, yyyy', locale).format(dateTime);
    } catch (_) {
      return isoDateStr;
    }
  }

  static String formatIsoToLocalizedDate(String isoDateStr, [String? locale]) {
    try {
      final DateTime dateTime = DateTime.parse(isoDateStr).toLocal();

      if (locale == 'ar') {
        return DateFormat('d MMMM yyyy', 'ar').format(dateTime);
      }

      final int day = dateTime.day;
      final String ordinal = _getOrdinalSuffix(day);
      final String formattedDate = DateFormat('MMM d', locale).format(dateTime);

      return '$formattedDate$ordinal, ${dateTime.year}';
    } catch (_) {
      return isoDateStr;
    }
  }

  static String formatNotificationCardSentTime(
    String isoDateStr, [
    String? locale,
  ]) {
    return isToday(isoDateStr)
        ? formatIsoToHourAndMinute(isoDateStr, locale)
        : formatIsoToFullDate(isoDateStr, locale);
  }

  static String timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    }
    if (difference.inMinutes < 60) {
      final int minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    }
    if (difference.inHours < 24) {
      final int hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }
    if (difference.inDays < 7) {
      final int days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    }

    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  static String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
