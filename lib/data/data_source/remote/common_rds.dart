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

  Future<Response> getSubjectsOfClass(String classId) {
    return client.get(
      '/subjects',
      queryParameters: {'classId': classId},
    );
  }

  Future<Response> getSubjectsOfCourse(String courseId) {
    return client.get(
      '/subjects',
      queryParameters: {'courseId': courseId},
    );
  }

  Future<Response> getAssignedSubjectsOfTeacher(String assignedTo) {
    return client.get(
      '/subjects',
      queryParameters: {'assignedTo': assignedTo},
    );
  }
}
