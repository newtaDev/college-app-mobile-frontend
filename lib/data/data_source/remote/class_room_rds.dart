import 'package:dio/dio.dart';

import '../../../domain/entities/class_room_entity.dart';
import '../../../shared/helpers/network/dio_client.dart';
import '../../models/request/comment_req.dart';

class ClassRoomRemoteDataSource {
  final client = DioClient.getClient();

  Future<Response> getAllSubjectResourcesWithCount(String subjectId) {
    return client.get(
      '/subject-resources/getAllSubjectResourcesWithCount',
      queryParameters: {'subjectId': subjectId},
    );
  }

  Future<Response> getSubjectResourceDetails(String resourceId) {
    return client.get(
      '/subject-resources/$resourceId',
    );
  }

  Future<Response> addCommentToSubjectResource(
    SubjectResourceCommentReq req,
  ) {
    return client.post(
      '/subject-resources/${req.resourceId}/addComment',
      data: req.toJson(),
    );
  }

  Future<Response> uploadSubjectResource({
    required UploadSubjectResourceReq req,
    void Function(int count, int total)? onUploadProgress,
  }) {
    return client.post(
      '/subject-resources/',
      data: req.toFormData(),
      onSendProgress: onUploadProgress,
    );
  }
}
