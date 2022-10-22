import '../../data/models/request/comment_req.dart';
import '../entities/class_room_entity.dart';
import '../entities/common_entity.dart';

abstract class ClassRoomRepository {
  Future<AllSubjectResourceRes> getAllSubjectResourcesWithCount(
    String subjectId,
  );
  Future<SubjectResourcesDetailsRes> getSubjectResourceDetails(
    String resourceId,
  );
  Future<void> addCommentToResource(SubjectResourceCommentReq comment);
}
