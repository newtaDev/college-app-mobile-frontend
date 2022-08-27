import '../entities/common_entity.dart';
import '../entities/user_entity.dart';

abstract class CommonRepository {
  Future<ClassWithDetailsRes> getClassesWithDetails();
  Future<UserDetailsRes> getUserDetails();
  Future<SubjectsRes> getSubjectsOfCourse(String courseId);
}
