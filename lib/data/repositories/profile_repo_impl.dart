import 'package:dartz/dartz.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../../shared/errors/api_errors.dart';

class ProfileRepoImpl implements ProfileRepository {
  @override
  Future<Either<UserProfileData, ApiErrorRes>> getProfileData() {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<UserProfileData, ApiErrorRes>> updateProfile() {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
