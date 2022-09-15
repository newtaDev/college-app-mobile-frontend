part of 'student_attendance_report_cubit.dart';

enum StudentAttendanceReportStatus { initial, loading, error, success }

extension StudentAttendanceReportStatusX on StudentAttendanceReportStatus {
  bool get isInitial => this == StudentAttendanceReportStatus.initial;
  bool get isSuccess => this == StudentAttendanceReportStatus.success;
  bool get isError => this == StudentAttendanceReportStatus.error;
  bool get isLoading => this == StudentAttendanceReportStatus.loading;
}

class StudentAttendanceReportState extends MyEquatable {
  final StudentAttendanceReportStatus status;
  final List<AbsentClassReportOfStudent> report;
  final ClassWithDetails? userClass;
  final ApiErrorRes? error;

  const StudentAttendanceReportState({
    required this.status,
    required this.report,
    required this.userClass,
    this.error,
  });

  StudentAttendanceReportState.init()
      : status = StudentAttendanceReportStatus.initial,
        report = [],
        userClass = null,
        error = null;

  @override
  List<Object?> get props => [status, report, userClass, error];

  StudentAttendanceReportState copyWith({
    StudentAttendanceReportStatus? status,
    List<AbsentClassReportOfStudent>? report,
    ClassWithDetails? userClass,
    ApiErrorRes? error,
  }) {
    return StudentAttendanceReportState(
      status: status ?? this.status,
      report: report ?? this.report,
      userClass: userClass ?? this.userClass,
      error: error ?? this.error,
    );
  }
}
