import '../../data/models/request/anouncement_req.dart';
import '../entities/anouncement_entity.dart';

abstract class AnouncementRepository {
  Future<void> createImageWithTextAnouncemet(ImageWithTextAnouncementReq req);
  Future<void> createOnlyTextAnouncement(OnlyTextAnouncementReq req);
  Future<void> createMultiImageWithTextAnouncement(
    MultiImageWithTextAnouncementRq req,
  );
  Future<AnouncementRes> getAnouncementForStudents({
    required String anounceToClassId,
    bool showMyClassesOnly = false,
  });
  Future<AnouncementRes> getAnouncementForTeachers({
    required String teacherId,
    bool showAnouncementsCreatedByMe = false,
  });
}
