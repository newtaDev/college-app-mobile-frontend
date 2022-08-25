import '../../domain/entities/profile_entity.dart';
import '../global/enums.dart';

class UserHelper {
  static UserProfileData setUserData({
    required UserType userType,
    required Map<String, dynamic> user,
  }) {
    if (userType == UserType.teacher) {
      return TeacherProfileData.fromMap(user);
    }
    if (userType == UserType.student) {}
    return StudentProfileData.fromMap(user);
  }
}
