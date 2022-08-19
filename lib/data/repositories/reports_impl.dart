import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/reports_entity.dart';
import '../../domain/repository/reports_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/reports_rds.dart';

class ReportsRepoImpl implements ReportsRepository {
  final ReportsRemoteDataSource attendanceRds;
  ReportsRepoImpl({required this.attendanceRds});

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
