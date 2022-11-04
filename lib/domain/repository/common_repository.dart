import '../entities/common_entity.dart';
import '../entities/user_entity.dart';

abstract class CommonRepository {
  Future<ClassWithDetailsRes> getAllClassesWithDetails();
  Future<ClassWithDetailsRes> getAccessibleClassesOfTeacher();
  Future<UserDetailsRes> getUserDetails();
  Future<SubjectsRes> getSubjectsOfCourse(String courseId);
  Future<SubjectsRes> getSubjectsOfClass(String classId);
  Future<SubjectsRes> getAssignedSubjectsOfTeacher(String assignedTo);
}
