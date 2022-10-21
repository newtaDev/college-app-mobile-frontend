import 'package:dio/dio.dart';

import '../../domain/entities/common_entity.dart';
import '../../domain/repository/class_room_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/class_room_rds.dart';

class ClassRoomRepoImpl implements ClassRoomRepository {
  final ClassRoomRemoteDataSource classRoomRds;

  ClassRoomRepoImpl({required this.classRoomRds});
  @override
  Future<SubjectsRes> getSubjectsOfClass(String classId) async {
    try {
      final res = await classRoomRds.getSubjectsOfClass(classId);
      return SubjectsRes.fromMap(res.data);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      throw errorRes;
    } catch (e) {
      rethrow;
    }
  }
}
