import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';

class StudentRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> getAllStudentsInClass({required String classId}) {
    return client.get(
      '/user/students',
      queryParameters: {'classId': classId},
    );
  }
}
