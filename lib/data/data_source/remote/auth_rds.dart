// remote api services

import 'package:dio/dio.dart';

import '../../../config/app_config.dart';
import '../../../domain/entities/auth_entitie.dart';

/// remote api calls
class AuthRemoteDataSource {
  final Dio dio = Dio();
  Future<Response> signUpUser(SignUpReq req) {
    final url = '${appEnv.baseUrl}/user/register';
    return dio.post(
      url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
        responseType: ResponseType.json,
      ),
      data: req.toJson(),
    );
  }

  Future<Response> signInUser(SignInReq req) {
    final url = '${appEnv.baseUrl}/user/login';
    return dio.post(
      url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
        responseType: ResponseType.json,
      ),
      data: req.toJson(),
    );
  }
}
