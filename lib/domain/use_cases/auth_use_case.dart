import '../repository/auth_repository.dart';

/// accepts data from multiple  repositories
class AuthUseCase {
  final AuthRepository authRepo;
  AuthUseCase({required this.authRepo});
}
