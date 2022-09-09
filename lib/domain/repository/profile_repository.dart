import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<void> checkUsernameExists(String username);
  Future<void> checkEmailExists(String email);
  Future<UserDetailsRes> updateStudentProfile(StudentUser student);
  Future<UserDetailsRes> updateTeacherProfile(TeacherUser teacher);
}