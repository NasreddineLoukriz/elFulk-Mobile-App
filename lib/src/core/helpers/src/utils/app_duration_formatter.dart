class AppDurationFormatter {
  const AppDurationFormatter._();

  static String formatDuration(Duration duration) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');

    final int hours = duration.inHours;
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }

    return '$minutes:$seconds';
  }
}
