// remote api services

import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';

/// remote api calls
class CommonRemoteDataSource {
  final client = DioClient.getClient();
  Future<Response> getClassesWithDetails() {
    return client.get(
      '/classes',
      queryParameters: {'showDetails': true},
    );
  }

  /// In backend`userId` and `userType` is taken from token
  Future<Response> getUserDetails() {
    return client.get('/user/details');
  }

  Future<Response> getSubjectsOfCourse(String courseId) {
    return client.get(
      '/subjects',
      queryParameters: {
        'courseId': courseId,
      },
    );
  }
}
