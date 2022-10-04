import '../../domain/entities/user_entity.dart';
import '../global/enums.dart';

class UserHelper {
  static UserDetails setUserData({
    required UserType userType,
    required Map<String, dynamic> user,
  }) {
    if (userType == UserType.teacher) {
      return TeacherUser.fromMap(user);
    }
    if (userType == UserType.student) {
      return StudentUser.fromMap(user);
    }
    return AnonymousUser.fromMap(user);
  }
}
