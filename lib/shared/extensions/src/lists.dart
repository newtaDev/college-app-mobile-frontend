part of app_extensions;

extension SafeLists<E> on List<E> {
  E? firstWhereSafe(bool Function(E element) test, {E? Function()? orElse}) {
    for (final E element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }
}
extension SafeIterables<E> on Iterable<E> {
  E? firstWhereSafe(bool Function(E element) test, {E? Function()? orElse}) {
    for (final E element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }
}
