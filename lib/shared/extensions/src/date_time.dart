part of app_extensions;

extension DateTimeX on DateTime {
  String toReadableString() {
    return DateFormat.yMMMEd().format(this);
  }
}
