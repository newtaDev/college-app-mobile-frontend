part of 'selection_cubit.dart';

enum AssignedClassesOfTeacherStatus { initial, loading, success, error }

enum CourseSubjectStatus { initial, loading, success, error }

extension AssignedClassesOfTeacherStatusX on AssignedClassesOfTeacherStatus {
  bool get isInitial => this == AssignedClassesOfTeacherStatus.initial;
  bool get isSuccess => this == AssignedClassesOfTeacherStatus.success;
  bool get isError => this == AssignedClassesOfTeacherStatus.error;
  bool get isLoading => this == AssignedClassesOfTeacherStatus.loading;
}

extension CourseSubjectStatusX on CourseSubjectStatus {
  bool get isInitial => this == CourseSubjectStatus.initial;
  bool get isSuccess => this == CourseSubjectStatus.success;
  bool get isError => this == CourseSubjectStatus.error;
  bool get isLoading => this == CourseSubjectStatus.loading;
}

class SelectionState extends MyEquatable {
  final List<ClassWithDetails> allClasses;
  final ClassWithDetails? selectedAllClasses;
  final AssignedClassesSelectonStates assignedClassesSelectonStates;
  final AssignedSubjectSelectionStates assignedSubjectSelectionStates;
  final ApiErrorRes? error;

  const SelectionState({
    this.allClasses = const [],
    this.selectedAllClasses,
    required this.assignedClassesSelectonStates,
    required this.assignedSubjectSelectionStates,
    this.error,
  });

  @override
  List<Object?> get props {
    return [
      allClasses,
      selectedAllClasses,
      assignedClassesSelectonStates,
      assignedSubjectSelectionStates,
      error,
    ];
  }

  const SelectionState.init()
      : allClasses = const [],
        assignedClassesSelectonStates =
            const AssignedClassesSelectonStates.empty(),
        assignedSubjectSelectionStates =
            const AssignedSubjectSelectionStates.empty(),
        error = null,
        selectedAllClasses = null;

  SelectionState copyWith({
    List<ClassWithDetails>? allClasses,
    ClassWithDetails? selectedAllClasses,
    AssignedClassesSelectonStates? assignedClassesSelectonStates,
    AssignedSubjectSelectionStates? assignedSubjectSelectionStates,
    ApiErrorRes? error,
  }) {
    return SelectionState(
      allClasses: allClasses ?? this.allClasses,
      selectedAllClasses: selectedAllClasses ?? this.selectedAllClasses,
      assignedClassesSelectonStates:
          assignedClassesSelectonStates ?? this.assignedClassesSelectonStates,
      assignedSubjectSelectionStates:
          assignedSubjectSelectionStates ?? this.assignedSubjectSelectionStates,
      error: error ?? this.error,
    );
  }

  SelectionState clearSubjects() {
    return SelectionState(
      allClasses: allClasses,
      selectedAllClasses: selectedAllClasses,
      assignedClassesSelectonStates: assignedClassesSelectonStates,
      assignedSubjectSelectionStates:
          const AssignedSubjectSelectionStates.empty(),
      error: error,
    );
  }
}

class AssignedClassesSelectonStates extends MyEquatable {
  final List<ClassWithDetails> assignedClassesOfTeacher;
  final ClassWithDetails? selectedClass;
  final int? selectedSem;
  final int? totalSem;
  final AssignedClassesOfTeacherStatus status;
  const AssignedClassesSelectonStates({
    required this.assignedClassesOfTeacher,
    this.selectedClass,
    this.selectedSem,
    this.totalSem,
    required this.status,
  });
  const AssignedClassesSelectonStates.empty()
      : assignedClassesOfTeacher = const [],
        status = AssignedClassesOfTeacherStatus.initial,
        selectedClass = null,
        selectedSem = null,
        totalSem = null;

  AssignedClassesSelectonStates copyWith({
    List<ClassWithDetails>? assignedClassesOfTeacher,
    ClassWithDetails? selectedClass,
    int? selectedSem,
    int? totalSem,
    AssignedClassesOfTeacherStatus? status,
  }) {
    return AssignedClassesSelectonStates(
      assignedClassesOfTeacher:
          assignedClassesOfTeacher ?? this.assignedClassesOfTeacher,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSem: selectedSem ?? this.selectedSem,
      totalSem: totalSem ?? this.totalSem,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      assignedClassesOfTeacher,
      selectedClass,
      selectedSem,
      totalSem,
      status,
    ];
  }
}

class AssignedSubjectSelectionStates extends MyEquatable {
  final CourseSubjectStatus status;
  final List<Subject> subjects;
  final Subject? selectedSubject;
  const AssignedSubjectSelectionStates({
    required this.status,
    required this.subjects,
    this.selectedSubject,
  });
  const AssignedSubjectSelectionStates.empty()
      : status = CourseSubjectStatus.initial,
        subjects = const [],
        selectedSubject = null;

  AssignedSubjectSelectionStates copyWith({
    CourseSubjectStatus? status,
    List<Subject>? subjects,
    Subject? selectedSubject,
  }) {
    return AssignedSubjectSelectionStates(
      status: status ?? this.status,
      subjects: subjects ?? this.subjects,
      selectedSubject: selectedSubject ?? this.selectedSubject,
    );
  }

  @override
  List<Object?> get props => [status, subjects, selectedSubject];
}
