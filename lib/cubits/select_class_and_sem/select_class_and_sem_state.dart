part of 'select_class_and_sem_cubit.dart';

enum SelectClassAndSemStatus { initial, loading, success, error }

extension SelectClassAndSemStatusX on SelectClassAndSemStatus {
  bool get isInitial => this == SelectClassAndSemStatus.initial;
  bool get isSuccess => this == SelectClassAndSemStatus.success;
  bool get isError => this == SelectClassAndSemStatus.error;
  bool get isLoading => this == SelectClassAndSemStatus.loading;
}

class SelectClassAndSemState extends MyEquatable {
  final List<ClassWithDetails> classes;
  final ClassWithDetails? selectedClass;
  final int? selectedSem;
  final int? totalSem;
  final SelectClassAndSemStatus status;
  final ApiErrorRes? error;

  const SelectClassAndSemState({
    this.classes = const [],
    this.selectedClass,
    this.selectedSem,
    this.totalSem,
    required this.status,
    this.error,
  });

  @override
  List<Object?> get props {
    return [
      classes,
      selectedClass,
      selectedSem,
      status,
      error,
      totalSem,
    ];
  }

  const SelectClassAndSemState.init()
      : status = SelectClassAndSemStatus.initial,
        classes = const [],
        error = null,
        selectedSem = null,
        totalSem = null,
        selectedClass = null;

  SelectClassAndSemState copyWith({
    List<ClassWithDetails>? classes,
    ClassWithDetails? selectedClass,
    int? selectedSem,
    int? totalSem,
    SelectClassAndSemStatus? status,
    ApiErrorRes? error,
  }) {
    return SelectClassAndSemState(
      classes: classes ?? this.classes,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSem: selectedSem ?? this.selectedSem,
      totalSem: totalSem ?? this.totalSem,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
