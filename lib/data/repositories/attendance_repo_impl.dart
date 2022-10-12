import 'package:dio/dio.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../domain/entities/reports_entity.dart';
import '../../domain/entities/students_entity.dart';
import '../../domain/repository/attendance_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/attendance_rds.dart';
import '../data_source/remote/user_rds.dart';

class AttendanceRepoImpl implements AttendanceRepository {
  final AttendannceRemoteDataSource attendanceRds;
  final UserRemoteDataSource studentRds;
  AttendanceRepoImpl({
    required this.attendanceRds,
    required this.studentRds,
  });

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
  Future<AttendanceWithCountRes> getClassAttendanceList(
    ClassAttendanceWithQueryReq req,
  ) async {
    try {
      final res = await attendanceRds.getClassAttendanceWithQueries(req);
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

  @override
  Future<StudentsInClassRes> getAllStudentInClass(String classId) async {
    try {
      final res = await studentRds.getAllStudentsInClass(classId: classId);
      return StudentsInClassRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateAttendance(UpdateAttendanceReq req) async {
    try {
      await attendanceRds.updateAttendance(req);
      return true;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AbsentClassReportOfStudentRes> getAbsentClassReportOfStudent(
    AbsentClassReportOfStudentReq req,
  ) async {
    try {
      final res = await attendanceRds.getAbsentClassesReportOfStudent(req);
      return AbsentClassReportOfStudentRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AttendanceWithCountRes> getSubjectAttendanceList(
    SubjectAttendanceWithQueryReq req,
  ) async {
    try {
      final res = await attendanceRds.getSubjectAttendanceWithQueries(req);
      return AttendanceWithCountRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
