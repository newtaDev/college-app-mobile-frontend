import 'package:dio/dio.dart';

import '../../domain/entities/common_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/common_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/common_rds.dart';
import '../data_source/remote/user_rds.dart';

class CommonRepoImpl implements CommonRepository {
  final CommonRemoteDataSource commonRds;
  final UserRemoteDataSource userRds;
  CommonRepoImpl({
    required this.commonRds,
    required this.userRds,
  });

  @override
  Future<ClassWithDetailsRes> getAllClassesWithDetails() async {
    try {
      final res = await commonRds.getAllClassesWithDetails();
      return ClassWithDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClassWithDetailsRes> getAccessibleClassesOfTeacher() async {
    try {
      final res = await userRds.getAccessibleClassesOfTeacher();
      return ClassWithDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDetailsRes> getUserDetails() async {
    try {
      final res = await userRds.getUserDetails();
      return UserDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubjectsRes> getSubjectsOfCourse(String courseId) async {
    try {
      final res = await commonRds.getSubjectsOfCourse(courseId);
      return SubjectsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubjectsRes> getAssignedSubjectsOfTeacher(String assignedTo) async {
    try {
      final res = await commonRds.getAssignedSubjectsOfTeacher(assignedTo);
      return SubjectsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubjectsRes> getSubjectsOfClass(String classId) async {
    try {
      final res = await commonRds.getSubjectsOfClass(classId);
      return SubjectsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
