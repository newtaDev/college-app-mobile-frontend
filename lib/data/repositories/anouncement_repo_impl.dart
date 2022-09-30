import 'package:dio/dio.dart';

import '../../domain/repository/anouncement_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/anouncement_rds.dart';
import '../models/request/anouncement_req.dart';

class AnouncementRepoImpl implements AnouncementRepository {
  final AnouncementRemoteDataSource anoucenementRds;

  AnouncementRepoImpl({required this.anoucenementRds});
  @override
  Future<void> createImageWithTextAnouncemet(
    ImageWithTextAnouncementReq req,
  ) async {
    try {
      await anoucenementRds.createImageWithTextAnouncement(req);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createMultiImageWithTextAnouncement(
    MultiImageWithTextAnouncementRq req,
  ) async {
    try {
      await anoucenementRds.createMultiImageWithTextAnouncement(req);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createOnlyTextAnouncement(OnlyTextAnouncementReq req) async {
    try {
      await anoucenementRds.createOnlyTextAnouncement(req);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
