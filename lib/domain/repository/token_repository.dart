import 'package:dio/dio.dart';

abstract class TokenRepository {
  Future<Response> reGenerateToken();
  Future<Response> decodeToken();
}
