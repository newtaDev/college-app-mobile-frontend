part of 'selection_cubit.dart';

enum SemAndClassStatus { initial, loading, success, error }

extension SemAndClassStatusX on SemAndClassStatus {
  bool get isInitial => this == SemAndClassStatus.initial;
  bool get isSuccess => this == SemAndClassStatus.success;
  bool get isError => this == SemAndClassStatus.error;
  bool get isLoading => this == SemAndClassStatus.loading;
}

enum SubjectStatus { initial, loading, success, error }

extension SubjectStatusX on SubjectStatus {
  bool get isInitial => this == SubjectStatus.initial;
  bool get isSuccess => this == SubjectStatus.success;
  bool get isError => this == SubjectStatus.error;
  bool get isLoading => this == SubjectStatus.loading;
}

class SelectionState extends MyEquatable {
  final List<ClassWithDetails> classes;
  final ClassWithDetails? selectedClass;
  final int? selectedSem;
  final int? totalSem;
  final SemAndClassStatus classAndSemStatus;
  final SubjectStatus subjectStatus;
  final List<Subject> subjects;
  final Subject? selectedSubject;
  final ApiErrorRes? error;

  const SelectionState({
    this.classes = const [],
    this.selectedClass,
    this.selectedSem,
    this.totalSem,
    required this.classAndSemStatus,
    required this.subjectStatus,
    required this.subjects,
    this.selectedSubject,
    this.error,
  });

  @override
  List<Object?> get props {
    return [
      classes,
      selectedClass,
      selectedSem,
      totalSem,
      classAndSemStatus,
      subjectStatus,
      subjects,
      error,
      selectedSubject
    ];
  }

  const SelectionState.init()
      : classAndSemStatus = SemAndClassStatus.initial,
        subjectStatus = SubjectStatus.initial,
        classes = const [],
        error = null,
        selectedSem = null,
        selectedSubject = null,
        totalSem = null,
        subjects = const [],
        selectedClass = null;

  SelectionState copyWith({
    List<ClassWithDetails>? classes,
    ClassWithDetails? selectedClass,
    int? selectedSem,
    int? totalSem,
    SemAndClassStatus? classAndSemStatus,
    SubjectStatus? subjectStatus,
    List<Subject>? subjects,
    Subject? selectedSubject,
    ApiErrorRes? error,
  }) {
    return SelectionState(
      classes: classes ?? this.classes,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSem: selectedSem ?? this.selectedSem,
      totalSem: totalSem ?? this.totalSem,
      classAndSemStatus: classAndSemStatus ?? this.classAndSemStatus,
      subjectStatus: subjectStatus ?? this.subjectStatus,
      subjects: subjects ?? this.subjects,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      error: error ?? this.error,
    );
  }

  SelectionState clearSubjects() {
    return SelectionState(
      classes: classes,
      selectedClass: selectedClass,
      selectedSem: selectedSem,
      totalSem: totalSem,
      classAndSemStatus: classAndSemStatus,
      subjectStatus: subjectStatus,
      subjects: const [],
      error: error,
    );
  }
}
