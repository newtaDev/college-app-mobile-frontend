part of 'class_time_table_cubit.dart';

enum ClassTimeTableStatus { initial, loading, success, error }

extension ClassTimeTableStatusX on ClassTimeTableStatus {
  bool get isInitial => this == ClassTimeTableStatus.initial;
  bool get isSuccess => this == ClassTimeTableStatus.success;
  bool get isError => this == ClassTimeTableStatus.error;
  bool get isLoading => this == ClassTimeTableStatus.loading;
}

class TimeTableTimes extends MyEquatable {
  final TimeOfDay startTime;
  final String timeTableId;
  const TimeTableTimes({
    required this.startTime,
    required this.timeTableId,
  });

  @override
  List<Object> get props => [startTime];
}

class ClassTimeTableState extends MyEquatable {
  final List<ClassTimeTable> clasTimeTables;
  final DateTime selectedDay;
  final ClassTimeTableStatus status;
  final ApiErrorRes? error;
  final List<DateTime> thisWeekDates;
  const ClassTimeTableState({
    required this.clasTimeTables,
    required this.selectedDay,
    required this.status,
    this.error,
    required this.thisWeekDates,
  });

  ClassTimeTableState.init()
      : clasTimeTables = [],
        error = null,
        selectedDay = DateTime.now(),
        thisWeekDates = [],
        status = ClassTimeTableStatus.initial;

  @override
  List<Object?> get props => [
        clasTimeTables,
        status,
        error,
        thisWeekDates,
        selectedDay,
      ];

  ClassTimeTableState copyWith({
    List<ClassTimeTable>? clasTimeTables,
    DateTime? selectedDay,
    ClassTimeTableStatus? status,
    ApiErrorRes? error,
    List<DateTime>? thisWeekDates,
  }) {
    return ClassTimeTableState(
      clasTimeTables: clasTimeTables ?? this.clasTimeTables,
      selectedDay: selectedDay ?? this.selectedDay,
      status: status ?? this.status,
      error: error ?? this.error,
      thisWeekDates: thisWeekDates ?? this.thisWeekDates,
    );
  }
}
