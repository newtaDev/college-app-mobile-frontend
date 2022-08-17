import 'dart:convert';
import 'dart:developer';

class ApiErrorRes implements Exception {
  final int statusCode;
  final String status;
  final String message;
  final String devMessage;
  final Map<String, dynamic>? errorStack;
  final Map<String, dynamic>? routeInfo;
  ApiErrorRes({
    this.status = 'ERROR',
    this.statusCode = 500,
    this.message = 'Internal Server Error',
    this.devMessage = 'something went wrong',
    this.errorStack,
    this.routeInfo,
  }) {
    toString();
  }

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
      status: map['status'],
      statusCode: map['statuscode']?.toInt() ?? 404,
      message: map['message'] ?? 'something went wrong',
      devMessage: map['devMsg'] ?? 'something went wrong',
      errorStack: map['errorStack'],
      routeInfo: map['routeInfo'],
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
    return 'ApiErrorRes(statusCode: $statusCode, status: $status, message: $message, devMessage: $devMessage, errorStack: $errorStack, routeInfo: $routeInfo)';
  }
}

class AppEception implements Exception {
  final String message;
  AppEception(this.message);
}
