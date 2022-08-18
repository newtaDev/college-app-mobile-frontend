import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../domain/repository/attendance_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/attendance_rds.dart';

class AttendanceRepoImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource attendanceRds;
  AttendanceRepoImpl({required this.attendanceRds});
  
  @override
  Future<Either<EachStudentReportRes, ApiErrorRes>>
      getAbsentStudentsReportInEachSubject(EachStudentReportReq req) async {
    try {
      final res = await attendanceRds.getAbsentStudentsReportInEachSubject(req);
      final attendanceRes = EachStudentReportRes.fromMap(res.data);
      return Left(attendanceRes);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      return Right(errorRes);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<SubjectReportRes, ApiErrorRes>> getAttendancesReportOfSubjects(
    SubjectReportReq req,
  ) async {
    try {
      final res = await attendanceRds.getAttendancesReportOfSubjects(req);
      final attendanceRes = SubjectReportRes.fromMap(res.data);
      return Left(attendanceRes);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      return Right(errorRes);
    } catch (e) {
      rethrow;
    }
  }
}
