part of app_extensions;

extension StringX on String {
  String getInitials({bool expandIfOnlyOne = false, int? takeUpto}) {
    if (isNotEmpty) {
      final splits = trim().split(' ');
      if (splits.length == 1 && expandIfOnlyOne) return this;
      return splits.map((l) => l[0]).take(takeUpto ?? 4).join();
    } else {
      return '';
    }
  }

  /// Format: 00:00
  TimeOfDay parseToTimeOfDay() {
    final now = DateTime.now();
    final splitedTime = split(':');
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(splitedTime[0]),
      int.parse(splitedTime[1]),
    );
    return TimeOfDay.fromDateTime(dateTime);
  }
}
