import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/common_entity.dart';
import '../../domain/repository/common_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/common_rds.dart';

class CommonRepoImpl implements CommonRepository {
  final CommonRemoteDataSource commonRds;
  CommonRepoImpl({required this.commonRds});

  @override
  Future<ClassWithDetailsRes> getClassesWithDetails() async {
    try {
      final res = await commonRds.getClassesWithDetails();
      return ClassWithDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
