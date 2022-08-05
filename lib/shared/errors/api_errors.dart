import 'dart:convert';
import 'dart:developer';

import '../../helpers/api_helpers/statuscode_helper.dart';

class ApiErrorRes implements Exception {
  final int statusCode;
  final String message;
  final String devMessage;
  ApiErrorRes({
    this.statusCode = 400,
    this.message = 'Internal Server Error',
    this.devMessage = 'something went wrong',
  });

  ApiErrorRes copyWith({
    int? statusCode,
    String? message,
    String? devMessage,
  }) {
    return ApiErrorRes(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      devMessage: devMessage ?? this.devMessage,
    );
  }

  factory ApiErrorRes.fromMap(Map<String, dynamic> map) {
    return ApiErrorRes(
      statusCode: map['code']?.toInt() ?? 404,
      message: map['error']['message'] ?? 'something went wrong',
      devMessage: map['error']['devMessage'] ?? 'something went wrong',
    );
  }

  factory ApiErrorRes.fromJson(String source) =>
      ApiErrorRes.fromMap(json.decode(source));

  @override
  String toString() {
    log(
      'ApiErrorRes -\n  code: $statusCode\n  msg: $message\n  devMsg: $devMessage',
      name: 'ERROR',
    );
    return super.toString();
  }
}

extension ApiStatuscodeChecker on ApiErrorRes {
  /// statuscode = 500 - 511
  bool get isServerError => StatusCodeHelper.isServerError(statusCode);

  /// statuscode = 200 - 226
  bool get isSuccess => StatusCodeHelper.isSuccess(statusCode);

  /// statuscode = 300 - 308
  bool get isRedirected => StatusCodeHelper.isRedirect(statusCode);

  /// statuscode = 400 - 541
  bool get isClientError => StatusCodeHelper.isClintError(statusCode);
}

class AppEception implements Exception {
  final String message;
  AppEception(this.message);
}
