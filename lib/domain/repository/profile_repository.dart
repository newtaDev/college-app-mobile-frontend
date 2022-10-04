import '../../shared/global/enums.dart';
import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<void> checkUsernameExists(String username);
  Future<void> checkEmailExists(String email);
  Future<UserDetailsRes> updateStudentProfile(StudentUser student);
  Future<UserDetailsRes> updateTeacherProfile(TeacherUser teacher);
  Future<UserDetailsRes> getProfile({
    required String userId,
    required UserType userType,
  });
  Future<SearchUserProfilesRes> searchUserProfiles({
    required String searchText,
  });
}
