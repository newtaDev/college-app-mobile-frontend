import 'package:dio/dio.dart';

import '../../domain/repository/time_table_repo.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/time_table_rds.dart';
import '../models/response/class_time_table_res.dart';

class TimeTableRepoImpl implements TimeTableRepository {
  final TimeTableRemoteDataSource timeTableRds;

  TimeTableRepoImpl({required this.timeTableRds});
  @override
  Future<ClassTimeTableRes> getClassTimeTableForStudent(String classId) async {
    try {
      final res = await timeTableRds.getClassTimeTableForStudent(classId);
      return ClassTimeTableRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClassTimeTableRes> getClassTimeTableForTeacher(
    String teacherId,
  ) async {
    try {
      final res = await timeTableRds.getClassTimeTableForTeacher(teacherId);
      return ClassTimeTableRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
