part of app_extensions;

extension ApiErrorResExt on ApiErrorRes {
  /// statuscode = 500 - 511
  bool get isServerError => StatusCodeHelper.isServerError(statusCode);

  /// statuscode = 200 - 226
  bool get isSuccess => StatusCodeHelper.isSuccess(statusCode);

  /// statuscode = 300 - 308
  bool get isRedirected => StatusCodeHelper.isRedirect(statusCode);

  /// statuscode = 400 - 541
  bool get isClientError => StatusCodeHelper.isClintError(statusCode);
}

extension DioResExt on Response {
  /// statuscode = 500 - 511
  bool get isServerError => StatusCodeHelper.isServerError(statusCode!);

  /// statuscode = 200 - 226
  bool get isSuccess => StatusCodeHelper.isSuccess(statusCode!);

  /// statuscode = 300 - 308
  bool get isRedirected => StatusCodeHelper.isRedirect(statusCode!);

  /// statuscode = 400 - 541
  bool get isClientError => StatusCodeHelper.isClintError(statusCode!);
}
