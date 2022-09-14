part of 'class_attendance_report_cubit.dart';

enum ClassAttendanceReportStatus { initial, loading, failure, success }

class ClassAttendanceReportState extends MyEquatable {
  final ClassAttendanceReportStatus subjectStatus;
  final ClassAttendanceReportStatus studentStatus;
  final List<SubjectReports> subjectReports;
  final List<EachStudentReport> studentReports;
  final String? selectedSubjectId;
  final ApiErrorRes? error;
  const ClassAttendanceReportState({
    required this.subjectStatus,
    required this.studentStatus,
    required this.subjectReports,
    required this.studentReports,
    this.selectedSubjectId,
    this.error,
  });

  @override
  List<Object?> get props {
    return [
      subjectStatus,
      studentStatus,
      subjectReports,
      studentReports,
      selectedSubjectId,
      error,
    ];
  }

  ClassAttendanceReportState.init()
      : subjectStatus = ClassAttendanceReportStatus.initial,
        studentStatus = ClassAttendanceReportStatus.initial,
        error = null,
        selectedSubjectId = null,
        studentReports = [],
        subjectReports = [];

  ClassAttendanceReportState copyWith({
    ClassAttendanceReportStatus? subjectStatus,
    ClassAttendanceReportStatus? studentStatus,
    List<SubjectReports>? subjectReports,
    List<EachStudentReport>? studentReports,
    String? selectedSubjectId,
    ApiErrorRes? error,
  }) {
    return ClassAttendanceReportState(
      subjectStatus: subjectStatus ?? this.subjectStatus,
      studentStatus: studentStatus ?? this.studentStatus,
      subjectReports: subjectReports ?? this.subjectReports,
      studentReports: studentReports ?? this.studentReports,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      error: error ?? this.error,
    );
  }
}
