part of 'attendance_report_cubit.dart';

enum AttendanceReportStatus { initial, loading, failure, success }

class AttendanceReportState extends Equatable {
  final AttendanceReportStatus subjectStatus;
  final AttendanceReportStatus studentStatus;
  final List<SubjectReports> subjectReports;
  final List<EachStudentReport> studentReports;
  final String? selectedSubjectId;
  final ApiErrorRes? error;
  const AttendanceReportState({
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

  AttendanceReportState.init()
      : subjectStatus = AttendanceReportStatus.initial,
        studentStatus = AttendanceReportStatus.initial,
        error = null,
        selectedSubjectId = null,
        studentReports = [],
        subjectReports = [];

  AttendanceReportState copyWith({
    AttendanceReportStatus? subjectStatus,
    AttendanceReportStatus? studentStatus,
    List<SubjectReports>? subjectReports,
    List<EachStudentReport>? studentReports,
    String? selectedSubjectId,
    ApiErrorRes? error,
  }) {
    return AttendanceReportState(
      subjectStatus: subjectStatus ?? this.subjectStatus,
      studentStatus: studentStatus ?? this.studentStatus,
      subjectReports: subjectReports ?? this.subjectReports,
      studentReports: studentReports ?? this.studentReports,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      error: error ?? this.error,
    );
  }
}
