import 'package:dartz/dartz.dart';

import '../../shared/errors/api_errors.dart';
import '../entities/auth_entitie.dart';

abstract class AuthRepository {
  Future<Either<AuthRes, ApiErrorRes>> signUpUser(SignUpReq req);
  Future<Either<AuthRes, ApiErrorRes>> signInUser(SignInReq req);
  Future<void> logoutUser();
}
