import 'package:dio/dio.dart';

import '../../../domain/entities/reports_entity.dart';
import '../../../shared/helpers/network/dio_client.dart';

class ReportsRemoteDataSource {
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
}
