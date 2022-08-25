import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../domain/entities/reports_entity.dart';
import '../../domain/repository/attendance_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/attendance_rds.dart';

class AttendanceRepoImpl implements AttendanceRepository {
  final AttendannceRemoteDataSource attendanceRds;
  AttendanceRepoImpl({required this.attendanceRds});

  @override
  Future<EachStudentReportRes> getAbsentStudentsReportInEachSubject(
    EachStudentReportReq req,
  ) async {
    try {
      final res = await attendanceRds.getAbsentStudentsReportInEachSubject(req);
      return EachStudentReportRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubjectReportRes> getAttendancesReportOfSubjects(
    SubjectReportReq req,
  ) async {
    try {
      final res = await attendanceRds.getAttendancesReportOfSubjects(req);
      return SubjectReportRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AttendanceWithCountRes> getAllAttendanceList(
    AllAttendanceWithQueryReq req,
  ) async {
    try {
      final res = await attendanceRds.getAllAttendanceWithQueries(req);
      return AttendanceWithCountRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createAttendance(CreateAttendanceReq req) async {
    try {
      await attendanceRds.createAttendance(req);
      return true;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
