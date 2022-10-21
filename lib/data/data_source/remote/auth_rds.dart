// remote api services

import 'package:dio/dio.dart';

import '../../../domain/entities/auth_entitie.dart';
import '../../../shared/helpers/network/dio_client.dart';

/// remote api calls
class AuthRemoteDataSource {
  final client = DioClient.getClient(isAuthorized: false);
  Future<Response> signUpUser(SignUpReq req) {
    return client.post(
      '/user/auth/register',
      data: req.toJson(),
    );
  }

  Future<Response> signInUser(SignInReq req) {
    return client.post(
      '/user/auth/login',
      data: req.toJson(),
    );
  }

  Future<Response> checkUsernameExists({required String username}) {
    return client.get(
      '/user/auth/validate',
      queryParameters: {'username': username},
    );
  }

  Future<Response> checkEmailExists({required String email}) {
    return client.get(
      '/user/auth/validate',
      queryParameters: {'email': email},
    );
  }
}
