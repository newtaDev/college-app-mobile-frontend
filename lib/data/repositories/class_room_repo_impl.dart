import 'package:dio/dio.dart';

import '../../domain/entities/class_room_entity.dart';
import '../../domain/repository/class_room_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/class_room_rds.dart';
import '../models/request/comment_req.dart';

class ClassRoomRepoImpl implements ClassRoomRepository {
  final ClassRoomRemoteDataSource classRoomRds;
  ClassRoomRepoImpl({required this.classRoomRds});

  @override
  Future<AllSubjectResourceRes> getAllSubjectResourcesWithCount(
    String subjectId,
  ) async {
    try {
      final res = await classRoomRds.getAllSubjectResourcesWithCount(subjectId);
      return AllSubjectResourceRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubjectResourcesDetailsRes> getSubjectResourceDetails(
    String resourceId,
  ) async {
    try {
      final res = await classRoomRds.getSubjectResourceDetails(resourceId);
      return SubjectResourcesDetailsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addCommentToResource(SubjectResourceCommentReq comment) async {
    try {
      await classRoomRds.addCommentToSubjectResource(comment);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> uploadSubjectResource({
    required UploadSubjectResourceReq req,
    void Function(int count, int total)? onUploadProgress,
  }) async {
    try {
      await classRoomRds.uploadSubjectResource(
        req: req,
        onUploadProgress: onUploadProgress,
      );
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
