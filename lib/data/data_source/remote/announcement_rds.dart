import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';
import '../../models/request/announcement_req.dart';

class AnnouncementRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> createImageWithTextAnnouncement(
    ImageWithTextAnnouncementReq req,
  ) {
    return client.post(
      '/announcements',
      data: req.toFormData(),
    );
  }

  Future<Response> createOnlyTextAnnouncement(
    OnlyTextAnnouncementReq req,
  ) {
    return client.post(
      '/announcements',
      data: req.toFormData(),
    );
  }

  Future<Response> createMultiImageWithTextAnnouncement(
    MultiImageWithTextAnnouncementRq req,
  ) {
    return client.post(
      '/announcements',
      data: req.toFormData(),
    );
  }

  Future<Response> getAnnouncementsForStudent({
    required String anounceToClassId,
    bool showMyClassesOnly = false,
  }) {
    return client.get(
      '/announcements/students',
      queryParameters: {
        'anounceToClassId': anounceToClassId,
        'showMyClassesOnly': showMyClassesOnly,
      },
    );
  }

  Future<Response> getAnnouncementsForTeacher({
    required String teacherId,
    bool showAnnouncementsCreatedByMe = false,
  }) {
    return client.get(
      '/announcements/teachers',
      queryParameters: {
        'teacherId': teacherId,
        'showAnnouncementsCreatedByMe': showAnnouncementsCreatedByMe,
      },
    );
  }
}
