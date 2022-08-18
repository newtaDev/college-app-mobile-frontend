import 'package:dartz/dartz.dart';

import '../../shared/errors/api_errors.dart';
import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<Either<SubjectReportRes, ApiErrorRes>> getAttendancesReportOfSubjects(
    SubjectReportReq req,
  );
  Future<Either<EachStudentReportRes, ApiErrorRes>>
      getAbsentStudentsReportInEachSubject(EachStudentReportReq req);
}
