import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../config/app_config.dart';
import '../../../data/data_source/local/auth_lds.dart';
import '../../../data/data_source/remote/token_rds.dart';
import '../../../data/repositories/token_repo_impl.dart';

class DioClient {
  static Dio getClient({
    String? baseUrl,
    BaseOptions? options,
    bool isAuthorized = true,
  }) {
    final _options = options ??
        BaseOptions(
          baseUrl: baseUrl ?? appEnv.baseUrl,
          connectTimeout: 20000,
          contentType: 'application/json',
        );
    final _dio = Dio(_options);
    if (isAuthorized) {
      _dio.interceptors.add(authorizedReqInterceptor());
    }
    _dio.interceptors.add(logReq());
    return _dio;
  }

  static InterceptorsWrapper logReq() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('--- REQUEST ---');
        debugPrint('${options.method}: ${options.uri}');
        return handler.next(options);
      },
      onError: (e, handler) {
        debugPrint('--- API ERROR ---');
        debugPrint(e.message);
        return handler.next(e);
      },
      onResponse: (res, handler) {
        debugPrint('--- RESPONSE ---');
        debugPrint('statuscode : ${res.statusCode} - ${res.statusMessage}');
        return handler.next(res);
      },
    );
  }

  static InterceptorsWrapper authorizedReqInterceptor() {
    final authLds = AuthLocalDataSource();
    final tokenRepo = TokenRepoImpl(
      authLds: authLds,
      tokenRds: TokenRemoteDataSource(),
    );

    return InterceptorsWrapper(
      onRequest: (reqOptions, handler) async {
        if (authLds.isAccessTokenExpired) {
          log('-- Access Token Expired --');
          try {
            await tokenRepo.reGenerateToken();
            log('-- Token Re-created --');
          } catch (e) {
            log('-- Re-creating token failed --');
            handler.reject(DioError(requestOptions: reqOptions));
            throw Exception('Re-creating Token Failed');
          }
        }
        reqOptions.headers.putIfAbsent('contentType', () => 'application/json');
        reqOptions.headers.putIfAbsent(
          'Authorization',
          () => 'Bearer ${authLds.accessToken}',
        );
        return handler.next(reqOptions);
      },
    );
  }
}
