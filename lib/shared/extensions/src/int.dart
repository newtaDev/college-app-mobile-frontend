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
}
