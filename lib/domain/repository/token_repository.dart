import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../shared/errors/api_errors.dart';

abstract class TokenRepository {
  Future<Either<Response, ApiErrorRes>> reGenerateToken();
  Future<Either<Response, ApiErrorRes>> decodeToken();
}
