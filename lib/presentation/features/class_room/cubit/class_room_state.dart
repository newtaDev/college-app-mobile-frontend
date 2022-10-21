part of 'class_room_cubit.dart';

enum ClassRoomStatus { initial, loading, success, error }

extension ClassRoomStatusX on ClassRoomStatus {
  bool get isInitial => this == ClassRoomStatus.initial;
  bool get isSuccess => this == ClassRoomStatus.success;
  bool get isError => this == ClassRoomStatus.error;
  bool get isLoading => this == ClassRoomStatus.loading;
}

class ClassRoomState extends Equatable {
  final ApiErrorRes? error;
  final ClassRoomStatus status;
  final List<Subject> mySubjects;

  const ClassRoomState({
    this.error,
    required this.status,
    required this.mySubjects,
  });

  const ClassRoomState.init()
      : status = ClassRoomStatus.initial,
        mySubjects = const [],
        error = null;

  @override
  List<Object?> get props => [status, error, mySubjects];

  ClassRoomState copyWith({
    ApiErrorRes? error,
    ClassRoomStatus? status,
    List<Subject>? mySubjects,
  }) {
    return ClassRoomState(
      error: error ?? this.error,
      status: status ?? this.status,
      mySubjects: mySubjects ?? this.mySubjects,
    );
  }
}
