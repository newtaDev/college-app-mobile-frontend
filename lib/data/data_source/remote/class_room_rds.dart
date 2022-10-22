import 'package:dio/dio.dart';

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
    SubjectResourceCommentReq commentReq,
  ) {
    return client.post(
      '/subject-resources/${commentReq.resourceId}/addComment',
      data: commentReq.toJson(),
    );
  }
  
}
