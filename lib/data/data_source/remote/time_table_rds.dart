import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';

class TimeTableRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> getClassTimeTableForTeacher(String teacherId) {
    return client.get(
      '/time_table/classes',
      queryParameters: {'teacherId': teacherId},
    );
  }

  Future<Response> getClassTimeTableForStudent(String classId) {
    return client.get(
      '/time_table/classes',
      queryParameters: {'classId': classId},
    );
  }
}
