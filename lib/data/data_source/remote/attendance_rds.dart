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

  Future<Response> getAllAttendanceWithQueries(AllAttendanceWithQueryReq req) {
    return client.get(
      '/attendance',
      queryParameters: req.toMap(),
    );
  }

  Future<Response> createAttendance(CreateAttendanceReq req) {
    print(req.toJson());
    return client.post(
      '/attendance',
      data: req.toJson(),
    );
  }
}
