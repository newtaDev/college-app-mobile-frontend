import 'package:dio/dio.dart';

import '../../../domain/entities/attendance_entity.dart';
import '../../../domain/entities/reports_entity.dart';
import '../../../shared/helpers/network/dio_client.dart';

class AttendannceRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> getAttendancesReportOfSubjects(SubjectReportReq req) {
    return client.get(
      '/attendance/report/subjects',
      queryParameters: req.toMap(),
    );
  }

  Future<Response> getAbsentStudentsReportInEachSubject(
    EachStudentReportReq req,
  ) {
    return client.get(
      '/attendance/report/subjects/students',
      queryParameters: req.toMap(),
    );
  }

  Future<Response> getAbsentClassesReportOfStudent(
    AbsentClassReportOfStudentReq req,
  ) {
    return client.get(
      '/attendance/report/subjects/students/${req.studentId}',
      queryParameters: req.toMap(),
    );
  }

  Future<Response> getClassAttendanceWithQueries(
    ClassAttendanceWithQueryReq req,
  ) {
    return client.get(
      '/attendance/queryByClass',
      queryParameters: req.toMap(),
    );
  }

  Future<Response> getSubjectAttendanceWithQueries(
    SubjectAttendanceWithQueryReq req,
  ) {
    return client.get(
      '/attendance/queryBySubject',
      queryParameters: req.toMap(),
    );
  }

  Future<Response> createAttendance(CreateAttendanceReq req) {
    return client.post(
      '/attendance',
      data: req.toJson(),
    );
  }

  Future<Response> updateAttendance(UpdateAttendanceReq req) {
    return client.put(
      '/attendance/${req.attendanceId}',
      data: req.toJson(),
    );
  }
}
