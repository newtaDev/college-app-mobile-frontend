part of app_utils;

extension EitherX<L, R> on Either<L, R> {
  R getRight() => (this as Right).value; //
  L getLeft() => (this as Left).value;
}
