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
}
