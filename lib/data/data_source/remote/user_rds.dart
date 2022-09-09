import 'package:dio/dio.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../shared/global/enums.dart';
import '../../../shared/helpers/network/dio_client.dart';

class UserRemoteDataSource {
  final client = DioClient.getClient();

  /// In backend`userId` and `userType` is taken from token
  Future<Response> getUserDetails() {
    return client.get('/user/details');
  }

  Future<Response> getAllStudentsInClass({required String classId}) {
    return client.get(
      '/user/students',
      queryParameters: {'classId': classId},
    );
  }

  Future<Response> checkUsernameExists({required String username}) {
    return client.get(
      '/user/validate',
      queryParameters: {'username': username},
    );
  }

  Future<Response> checkEmailExists({required String email}) {
    return client.get(
      '/user/validate',
      queryParameters: {'email': email},
    );
  }

  Future<Response> updateStudentProfile(StudentUser student) {
    return client.put(
      '/user/students/${student.id}',
      data: student.toJson(),
    );
  }

  Future<Response> updateTeacherProfile(TeacherUser teacher) {
    return client.put(
      '/user/teachers/${teacher.id}',
      data: teacher.toJson(),
    );
  }

  Future<Response> getProfile({String? userId, required UserType userType}) {
    return client.get(
      '/user/profiles/$userId',
      queryParameters: {'userType': userType.value},
    );
  }
}
