import '../entities/common_entity.dart';

abstract class ClassRoomRepository {
  Future<SubjectsRes> getSubjectsOfClass(String classId);
}
