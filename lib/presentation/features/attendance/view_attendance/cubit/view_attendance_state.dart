part of 'view_attendance_cubit.dart';

enum ViewAttendanceStatus { initial, loading, success, error }

extension ViewAttendanceStatusX on ViewAttendanceStatus {
  bool get isInitial => this == ViewAttendanceStatus.initial;
  bool get isSuccess => this == ViewAttendanceStatus.success;
  bool get isError => this == ViewAttendanceStatus.error;
  bool get isLoading => this == ViewAttendanceStatus.loading;
}

class ViewAttendanceState extends MyEquatable {
  final List<AttendanceWithCount> attendanceWithCount;
  final ViewAttendanceStatus status;
  final ApiErrorRes? error;

  const ViewAttendanceState({
    required this.attendanceWithCount,
    required this.status,
    this.error,
  });

  const ViewAttendanceState.init()
      : attendanceWithCount = const [],
        error = null,
        status = ViewAttendanceStatus.initial;

  @override
  List<Object?> get props => [attendanceWithCount, status, error];

  ViewAttendanceState copyWith({
    List<AttendanceWithCount>? attendanceWithCount,
    ViewAttendanceStatus? status,
    ApiErrorRes? error,
  }) {
    return ViewAttendanceState(
      attendanceWithCount: attendanceWithCount ?? this.attendanceWithCount,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
