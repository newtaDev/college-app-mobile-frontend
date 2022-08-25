import 'package:dartz/dartz.dart';

import '../../shared/errors/api_errors.dart';
import '../entities/auth_entitie.dart';

abstract class AuthRepository {
  Future<AuthRes> signUpUser(SignUpReq req);
  Future<AuthRes> signInUser(SignInReq req);
  Future<void> logoutUser();
}
