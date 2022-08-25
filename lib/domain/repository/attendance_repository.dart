import '../entities/attendance_entity.dart';
import '../entities/user_entity.dart';
import '../entities/reports_entity.dart';

abstract class AttendanceRepository {
  Future<SubjectReportRes> getAttendancesReportOfSubjects(
    SubjectReportReq req,
  );
  Future<EachStudentReportRes> getAbsentStudentsReportInEachSubject(
    EachStudentReportReq req,
  );

  Future<AttendanceWithCountRes> getAllAttendanceList(
    AllAttendanceWithQueryReq req,
  );

  Future<bool> createAttendance(CreateAttendanceReq req);

  Future<StudentUser> getAllStudentInClass(String classId);
}
