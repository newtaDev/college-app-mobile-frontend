import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/attendance_entity.dart';
import '../../domain/entities/reports_entity.dart';
import '../../domain/repository/attendance_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../data_source/remote/attendance_rds.dart';

class AttendanceRepoImpl implements AttendanceRepository {
  final AttendannceRemoteDataSource attendanceRds;
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

  @override
  Future<Either<AttendanceWithCountRes, ApiErrorRes>> getAllAttendanceList(
    AllAttendanceWithQueryReq req,
  ) async {
    try {
      final res = await attendanceRds.getAllAttendanceWithQueries(req);
      final attendanceRes = AttendanceWithCountRes.fromMap(res.data);
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
  Future<Either<bool, ApiErrorRes>> createAttendance(
    CreateAttendanceReq req,
  ) async {
    try {
      await attendanceRds.createAttendance(req);
      return const Left(true);
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) rethrow;
      final errorRes = ApiErrorRes.fromMap(e.response?.data);
      return Right(errorRes);
    } catch (e) {
      rethrow;
    }
  }
}
