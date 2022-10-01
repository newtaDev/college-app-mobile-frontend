import 'package:dio/dio.dart';

import '../../../shared/helpers/network/dio_client.dart';
import '../../models/request/anouncement_req.dart';

class AnouncementRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> createImageWithTextAnouncement(
    ImageWithTextAnouncementReq req,
  ) {
    return client.post(
      '/anouncements',
      data: req.toFormData(),
    );
  }

  Future<Response> createOnlyTextAnouncement(
    OnlyTextAnouncementReq req,
  ) {
    return client.post(
      '/anouncements',
      data: req.toFormData(),
    );
  }

  Future<Response> createMultiImageWithTextAnouncement(
    MultiImageWithTextAnouncementRq req,
  ) {
    return client.post(
      '/anouncements',
      data: req.toFormData(),
    );
  }

  Future<Response> getAnouncementsForStudent({
    required String anounceToClassId,
    bool showMyClassesOnly = false,
  }) {
    return client.get(
      '/anouncements/students',
      queryParameters: {
        'anounceToClassId': anounceToClassId,
        'showMyClassesOnly': showMyClassesOnly,
      },
    );
  }

  Future<Response> getAnouncementsForTeacher({
    required String teacherId,
    bool showAnouncementsCreatedByMe = false,
  }) {
    return client.get(
      '/anouncements/teachers',
      queryParameters: {
        'teacherId': teacherId,
        'showAnouncementsCreatedByMe': showAnouncementsCreatedByMe,
      },
    );
  }
}
