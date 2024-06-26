import 'package:dio/dio.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../../shared/global/enums.dart';
import '../data_source/remote/auth_rds.dart';
import '../data_source/remote/user_rds.dart';

class ProfileRepoImpl implements ProfileRepository {
  final UserRemoteDataSource userRds;
  final AuthRemoteDataSource authRds;
  ProfileRepoImpl({
    required this.userRds,
    required this.authRds,
  });

  @override
  Future<void> checkEmailExists(String email) async {
    try {
      await authRds.checkEmailExists(email: email);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      if (e.response?.statusCode == null) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);

      /// Duplicate
      if (e.response!.statusCode == 409) {
        throw errorRes.copyWith(message: 'Email already exists');
      }
      throw errorRes.copyWith(message: 'Internal server error');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> checkUsernameExists(String username) async {
    try {
      await authRds.checkUsernameExists(username: username);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      if (e.response?.statusCode == null) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);

      /// Duplicate
      if (e.response!.statusCode == 409) {
        throw errorRes.copyWith(message: 'Username already exists');
      }
      throw errorRes.copyWith(message: 'Internal server error');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDetailsRes> updateStudentProfile(StudentUser student) async {
    try {
      final res = await userRds.updateStudentProfile(student);
      return UserDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDetailsRes> updateTeacherProfile(TeacherUser teacher) async {
    try {
      final res = await userRds.updateTeacherProfile(teacher);
      return UserDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDetailsRes> getProfile({
    required String userId,
    required UserType userType,
  }) async {
    try {
      final res = await userRds.getProfile(userType: userType, userId: userId);
      return UserDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SearchUserProfilesRes> searchUserProfiles({
    required String searchText,
  }) async {
    try {
      final res = await userRds.searchUserProfiles(searchText: searchText);
      return SearchUserProfilesRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
