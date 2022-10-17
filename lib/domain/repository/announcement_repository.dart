import '../../data/models/request/announcement_req.dart';
import '../entities/announcement_entity.dart';

abstract class AnnouncementRepository {
  Future<void> createImageWithTextAnouncemet(ImageWithTextAnnouncementReq req);
  Future<void> createOnlyTextAnnouncement(OnlyTextAnnouncementReq req);
  Future<void> createMultiImageWithTextAnnouncement(
    MultiImageWithTextAnnouncementRq req,
  );
  Future<AnnouncementRes> getAnnouncementForStudents({
    required String anounceToClassId,
    bool showMyClassesOnly = false,
  });
  Future<AnnouncementRes> getAnnouncementForTeachers({
    required String teacherId,
    bool showAnnouncementsCreatedByMe = false,
  });
}
