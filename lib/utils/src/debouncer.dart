part of app_utils;

class Debouncer {
  Debouncer({
    required this.delay,
  });

  final Duration delay;
  Timer? _timer;

  Timer run(VoidCallback action) {
    _timer?.cancel();
    return _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
