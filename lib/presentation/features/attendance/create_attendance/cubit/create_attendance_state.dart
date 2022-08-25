part of 'create_attendance_cubit.dart';

enum CreateAttendanceStatus { initial, loading, success, error }

extension CreateAttendanceStatusX on CreateAttendanceStatus {
  bool get isInitial => this == CreateAttendanceStatus.initial;
  bool get isSuccess => this == CreateAttendanceStatus.success;
  bool get isError => this == CreateAttendanceStatus.error;
  bool get isLoading => this == CreateAttendanceStatus.loading;
}

class CreateAttendanceState extends MyEquatable {
  final CreateAttendanceStatus status;
  final bool? isCreated;
  final ApiErrorRes? error;

  const CreateAttendanceState({
    required this.status,
    this.isCreated,
    this.error,
  });

  const CreateAttendanceState.init()
      : status = CreateAttendanceStatus.initial,
        error = null,
        isCreated = null;

  @override
  List<Object?> get props => [status, isCreated, error];

  CreateAttendanceState copyWith({
    CreateAttendanceStatus? status,
    bool? isCreated,
    ApiErrorRes? error,
  }) {
    return CreateAttendanceState(
      status: status ?? this.status,
      isCreated: isCreated ?? this.isCreated,
      error: error ?? this.error,
    );
  }
}
