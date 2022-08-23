part of 'attendance_view_cubit.dart';

enum AttendanceViewStatus { initial, loading, success, error }

extension AttendanceViewStatusX on AttendanceViewStatus {
  bool get isInitial => this == AttendanceViewStatus.initial;
  bool get isSuccess => this == AttendanceViewStatus.success;
  bool get isError => this == AttendanceViewStatus.error;
  bool get isLoading => this == AttendanceViewStatus.loading;
}

class AttendanceViewState extends MyEquatable {
  final List<AttendanceWithCount> attendanceWithCount;
  final AttendanceViewStatus status;
  final ApiErrorRes? error;

  const AttendanceViewState({
    required this.attendanceWithCount,
    required this.status,
    this.error,
  });

  const AttendanceViewState.init()
      : attendanceWithCount = const [],
        error = null,
        status = AttendanceViewStatus.initial;

  @override
  List<Object?> get props => [attendanceWithCount, status, error];

  AttendanceViewState copyWith({
    List<AttendanceWithCount>? attendanceWithCount,
    AttendanceViewStatus? status,
    ApiErrorRes? error,
  }) {
    return AttendanceViewState(
      attendanceWithCount: attendanceWithCount ?? this.attendanceWithCount,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
