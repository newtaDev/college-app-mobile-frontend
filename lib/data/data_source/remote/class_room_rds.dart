import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';

class ClassRoomRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> getSubjectsOfClass(String classId) {
    return client.get(
      '/subjects',
      queryParameters: {'classId': classId},
    );
  }
}
