import 'package:dio/dio.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../../shared/global/enums.dart';
import '../data_source/remote/profile_rds.dart';

class ProfileRepoImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRds;

  ProfileRepoImpl({required this.profileRds});
  @override
  Future<ProfileRes> getProfileData({
    required String id,
    required UserType userType,
  }) async {
    try {
      final res = await profileRds.getProfileData(id: id, userType: userType);
      return ProfileRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserProfileData> updateProfile() {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
