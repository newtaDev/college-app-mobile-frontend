import 'package:dio/dio.dart';

import '../../domain/entities/announcement_entity.dart';
import '../../domain/repository/announcement_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/announcement_rds.dart';
import '../models/request/announcement_req.dart';

class AnnouncementRepoImpl implements AnnouncementRepository {
  final AnnouncementRemoteDataSource anoucenementRds;

  AnnouncementRepoImpl({required this.anoucenementRds});
  @override
  Future<void> createImageWithTextAnouncemet(
    ImageWithTextAnnouncementReq req,
  ) async {
    try {
      await anoucenementRds.createImageWithTextAnnouncement(req);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createMultiImageWithTextAnnouncement(
    MultiImageWithTextAnnouncementRq req,
  ) async {
    try {
      await anoucenementRds.createMultiImageWithTextAnnouncement(req);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createOnlyTextAnnouncement(OnlyTextAnnouncementReq req) async {
    try {
      await anoucenementRds.createOnlyTextAnnouncement(req);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AnnouncementRes> getAnnouncementForStudents({
    required String anounceToClassId,
    bool showMyClassesOnly = false,
  }) async {
    try {
      final res = await anoucenementRds.getAnnouncementsForStudent(
        anounceToClassId: anounceToClassId,
        showMyClassesOnly: showMyClassesOnly,
      );
      return AnnouncementRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AnnouncementRes> getAnnouncementForTeachers({
    required String teacherId,
    bool showAnnouncementsCreatedByMe = false,
  }) async {
    try {
      final res = await anoucenementRds.getAnnouncementsForTeacher(
        teacherId: teacherId,
        showAnnouncementsCreatedByMe: showAnnouncementsCreatedByMe,
      );
      return AnnouncementRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
