import '../entities/class_room_entity.dart';
import '../entities/common_entity.dart';

abstract class ClassRoomRepository {
  Future<AllSubjectResourceRes> getAllSubjectResourcesWithCount(
    String subjectId,
  );
  Future<SubjectResourcesDetailsRes> getSubjectResourceDetails(
    String resourceId,
  );
}
