import 'package:dartz/dartz.dart';

import '../../shared/errors/api_errors.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<UserProfileData, ApiErrorRes>> getProfileData();
  Future<Either<UserProfileData, ApiErrorRes>> updateProfile();
}
