import '../entities/attendance_entity.dart';
import '../entities/reports_entity.dart';
import '../entities/students_entity.dart';

abstract class AttendanceRepository {
  Future<SubjectReportRes> getAttendancesReportOfSubjects(
    SubjectReportReq req,
  );
  Future<EachStudentReportRes> getAbsentStudentsReportInEachSubject(
    EachStudentReportReq req,
  );
  Future<AbsentClassReportOfStudentRes> getAbsentClassReportOfStudent(
    AbsentClassReportOfStudentReq req,
  );

  Future<AttendanceWithCountRes> getClassAttendanceList(
    ClassAttendanceWithQueryReq req,
  );
  Future<AttendanceWithCountRes> getSubjectAttendanceList(
    SubjectAttendanceWithQueryReq req,
  );

  Future<bool> createAttendance(CreateAttendanceReq req);
  Future<bool> updateAttendance(UpdateAttendanceReq req);

  Future<StudentsInClassRes> getAllStudentInClass(String classId);
}
