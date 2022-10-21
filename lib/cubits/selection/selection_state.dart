part of 'selection_cubit.dart';

enum SelectionStatus { initial, loading, success, error }

extension SelectionStatusX on SelectionStatus {
  bool get isInitial => this == SelectionStatus.initial;
  bool get isSuccess => this == SelectionStatus.success;
  bool get isError => this == SelectionStatus.error;
  bool get isLoading => this == SelectionStatus.loading;
}

class SelectionState extends MyEquatable {
  final List<ClassWithDetails> allClasses;
  final ClassWithDetails? selectedAllClasses;
  final AccessibleClassesStates accessibleClassesStates;
  final AccessibleSubjectStates accessibleSubjectStates;
  final ApiErrorRes? error;

  const SelectionState({
    this.allClasses = const [],
    this.selectedAllClasses,
    required this.accessibleClassesStates,
    required this.accessibleSubjectStates,
    this.error,
  });

  @override
  List<Object?> get props {
    return [
      allClasses,
      selectedAllClasses,
      accessibleClassesStates,
      accessibleSubjectStates,
      error,
    ];
  }

  const SelectionState.init()
      : allClasses = const [],
        accessibleClassesStates = const AccessibleClassesStates.empty(),
        accessibleSubjectStates = const AccessibleSubjectStates.empty(),
        error = null,
        selectedAllClasses = null;

  SelectionState copyWith({
    List<ClassWithDetails>? allClasses,
    ClassWithDetails? selectedAllClasses,
    AccessibleClassesStates? accessibleClassesStates,
    AccessibleSubjectStates? accessibleSubjectStates,
    ApiErrorRes? error,
  }) {
    return SelectionState(
      allClasses: allClasses ?? this.allClasses,
      selectedAllClasses: selectedAllClasses ?? this.selectedAllClasses,
      accessibleClassesStates:
          accessibleClassesStates ?? this.accessibleClassesStates,
      accessibleSubjectStates:
          accessibleSubjectStates ?? this.accessibleSubjectStates,
      error: error ?? this.error,
    );
  }

  SelectionState clearSubjects() {
    return SelectionState(
      allClasses: allClasses,
      selectedAllClasses: selectedAllClasses,
      accessibleClassesStates: accessibleClassesStates,
      accessibleSubjectStates: const AccessibleSubjectStates.empty(),
      error: error,
    );
  }
}

class AccessibleClassesStates extends MyEquatable {
  final List<ClassWithDetails> classes;
  final ClassWithDetails? selectedClass;
  final int? selectedSem;
  final int? totalSem;
  final SelectionStatus status;
  const AccessibleClassesStates({
    required this.classes,
    this.selectedClass,
    this.selectedSem,
    this.totalSem,
    required this.status,
  });
  const AccessibleClassesStates.empty()
      : classes = const [],
        status = SelectionStatus.initial,
        selectedClass = null,
        selectedSem = null,
        totalSem = null;

  AccessibleClassesStates copyWith({
    List<ClassWithDetails>? classes,
    ClassWithDetails? selectedClass,
    int? selectedSem,
    int? totalSem,
    SelectionStatus? status,
  }) {
    return AccessibleClassesStates(
      classes: classes ?? this.classes,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSem: selectedSem ?? this.selectedSem,
      totalSem: totalSem ?? this.totalSem,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      classes,
      selectedClass,
      selectedSem,
      totalSem,
      status,
    ];
  }
}

class AccessibleSubjectStates extends MyEquatable {
  final SelectionStatus status;
  final List<Subject> subjects;
  final Subject? selectedSubject;
  const AccessibleSubjectStates({
    required this.status,
    required this.subjects,
    this.selectedSubject,
  });
  const AccessibleSubjectStates.empty()
      : status = SelectionStatus.initial,
        subjects = const [],
        selectedSubject = null;

  AccessibleSubjectStates copyWith({
    SelectionStatus? status,
    List<Subject>? subjects,
    Subject? selectedSubject,
  }) {
    return AccessibleSubjectStates(
      status: status ?? this.status,
      subjects: subjects ?? this.subjects,
      selectedSubject: selectedSubject ?? this.selectedSubject,
    );
  }

  @override
  List<Object?> get props => [status, subjects, selectedSubject];
}
