part of app_extensions;

extension DateTimeX on DateTime {
  String toReadableString() {
    return DateFormat.yMMMEd().format(this);
  }

  String toNormalString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toTimeAgo() {
    final int diffInHours = DateTime.now().difference(this).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;
    String? rawString;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(this).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
      if (timeValue <= 0) {
        rawString = 'Just now';
      }
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
      if (timeValue <= 0) {
        rawString = '1 year ago';
      }
    }

    timeAgo = '$timeValue $timeUnit';
    timeAgo += timeValue > 1 ? 's' : '';

    return rawString ?? '$timeAgo ago';
  }

  String toDayAgoWithDate() {
    final int diffInHours = DateTime.now().difference(this).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;
    String? rawString;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(this).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
      if (timeValue <= 0) {
        rawString = 'Just now';
      }
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else {
      rawString = DateFormat.yMMMd().format(this);
    }

    timeAgo = '$timeValue $timeUnit';
    timeAgo += timeValue > 1 ? 's' : '';

    return rawString ?? '$timeAgo ago';
  }
}
