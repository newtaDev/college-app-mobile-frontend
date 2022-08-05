import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../config/app_config.dart';
import '../../domain/entities/auth_entitie.dart';
import '../../domain/repository/auth_repository.dart';

import '../../shared/errors/api_errors.dart';
import '../data_source/remote/auth_rds.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource = getIt<AuthRemoteDataSource>();

  AuthRepoImpl();
  @override
  Future<Either<AuthRes, ApiErrorRes>> signInUser(SignInReq req) async {
    try {
      final res = await remoteDataSource.signInUser(req);
      final authRes = AuthRes.fromMap(res.data);
      return Left(authRes);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      return Right(errorRes);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<AuthRes, ApiErrorRes>> signUpUser(SignUpReq req) async {
    try {
      final res = await remoteDataSource.signUpUser(req);
      final authRes = AuthRes.fromMap(res.data);
      return Left(authRes);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      return Right(errorRes);
    } catch (e) {
      rethrow;
    }
  }
}
