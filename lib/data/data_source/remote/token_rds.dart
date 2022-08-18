import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';

class TokenRemoteDataSource {
  final client = DioClient.getClient(isAuthorized: false);

  Future<Response> reGenerateToken(String refreshToken) {
    return client.post(
      '/token/re_create',
      data: {'refreshToken': refreshToken},
    );
  }
}
