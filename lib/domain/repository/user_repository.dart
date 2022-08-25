import '../../shared/global/enums.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserDetailsRes> getUserDetails();
  Future<UserDetails> updateUser();
}
