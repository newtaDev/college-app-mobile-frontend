// remote api services

import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';

/// remote api calls
class CommonRemoteDataSource {
  final client = DioClient.getClient();
  Future<Response> getAllClassesWithDetails() {
    return client.get(
      '/classes',
      queryParameters: {'showDetails': true},
    );
  }

  Future<Response> getSubjectsOfCourse(String courseId) {
    return client.get(
      '/subjects',
      queryParameters: {'courseId': courseId},
    );
  }
}
