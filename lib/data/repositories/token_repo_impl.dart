import 'package:dio/dio.dart';

import '../../domain/repository/token_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/local/auth_lds.dart';
import '../data_source/remote/token_rds.dart';

class TokenRepoImpl implements TokenRepository {
  final TokenRemoteDataSource tokenRds;
  final AuthLocalDataSource authLds;
  TokenRepoImpl({
    required this.tokenRds,
    required this.authLds,
  });
  @override
  Future<Response> reGenerateToken() async {
    if (authLds.refreshToken == null) {
      throw Exception('Refresh token Not found');
    }
    if (authLds.isRefreshTokenExpired) {
      throw Exception('Refresh token Expired');
    }
    try {
      final res = await tokenRds.reGenerateToken(authLds.refreshToken!);
      final _data = res.data['responseData'];
      await authLds.setTokens(
        accessToken: _data['accessToken'],
        refreshToken: _data['refreshToken'],
      );
      return res;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> decodeToken() {
    throw UnimplementedError();
  }
}
