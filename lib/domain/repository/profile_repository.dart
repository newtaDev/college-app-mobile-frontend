import 'package:dartz/dartz.dart';

import '../../shared/errors/api_errors.dart';
import '../../shared/global/enums.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileRes> getProfileData({
    required String id,
    required UserType userType,
  });
  Future<UserProfileData> updateProfile();
}
