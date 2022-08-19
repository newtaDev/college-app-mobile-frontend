part of 'attendance_cubit.dart';

enum AttendanceStatus { initial, loading, failure, success }

class AttendanceState extends Equatable {
  final AttendanceStatus subjectStatus;
  final AttendanceStatus studentStatus;
  final List<SubjectReports> subjectReports;
  final List<EachStudentReport> studentReports;
  final String? selectedSubjectId;
  final ApiErrorRes? error;
  const AttendanceState({
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

  AttendanceState.init()
      : subjectStatus = AttendanceStatus.initial,
        studentStatus = AttendanceStatus.initial,
        error = null,
        selectedSubjectId = null,
        studentReports = [],
        subjectReports = [];

  AttendanceState copyWith({
    AttendanceStatus? subjectStatus,
    AttendanceStatus? studentStatus,
    List<SubjectReports>? subjectReports,
    List<EachStudentReport>? studentReports,
    String? selectedSubjectId,
    ApiErrorRes? error,
  }) {
    return AttendanceState(
      subjectStatus: subjectStatus ?? this.subjectStatus,
      studentStatus: studentStatus ?? this.studentStatus,
      subjectReports: subjectReports ?? this.subjectReports,
      studentReports: studentReports ?? this.studentReports,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      error: error ?? this.error,
    );
  }
}
