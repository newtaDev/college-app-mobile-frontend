part of app_extensions;

extension IntX on int {
  String get getRankPosition {
    switch (this) {
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

  String convertBytesToReadableSize() {
    final int bytes = this;
    const fractions = 2;
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(fractions)} ${suffixes[i]}';
  }
}
