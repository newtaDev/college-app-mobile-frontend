import '../../data/models/request/anouncement_req.dart';

abstract class AnouncementRepository {
  Future<void> createImageWithTextAnouncemet(ImageWithTextAnouncementReq req);
  Future<void> createOnlyTextAnouncement(OnlyTextAnouncementReq req);
  Future<void> createMultiImageWithTextAnouncement(
    MultiImageWithTextAnouncementRq req,
  );
}
