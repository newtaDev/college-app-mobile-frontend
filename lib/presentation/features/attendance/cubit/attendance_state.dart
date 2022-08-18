part of 'attendance_cubit.dart';

enum AttendanceStatus { initial, loading, failure, success }

class AttendanceState extends Equatable {
  final AttendanceStatus subjectStatus;
  final AttendanceStatus studentStatus;
  final List<SubjectReports> subjectReports;
  final List<EachStudentReport> studentReports;
  final ApiErrorRes? error;
  const AttendanceState({
    required this.subjectStatus,
    required this.studentStatus,
    required this.subjectReports,
    required this.studentReports,
    this.error,
  });

  @override
  List<Object?> get props {
    return [
      subjectStatus,
      studentStatus,
      subjectReports,
      studentReports,
      error,
    ];
  }

  AttendanceState.init()
      : subjectStatus = AttendanceStatus.initial,
        studentStatus = AttendanceStatus.initial,
        error = null,
        studentReports = [],
        subjectReports = [];

  AttendanceState copyWith({
    AttendanceStatus? subjectStatus,
    AttendanceStatus? studentStatus,
    List<SubjectReports>? subjectReports,
    List<EachStudentReport>? studentReports,
    ApiErrorRes? error,
  }) {
    return AttendanceState(
      subjectStatus: subjectStatus ?? this.subjectStatus,
      studentStatus: studentStatus ?? this.studentStatus,
      subjectReports: subjectReports ?? this.subjectReports,
      studentReports: studentReports ?? this.studentReports,
      error: error ?? this.error,
    );
  }
}
