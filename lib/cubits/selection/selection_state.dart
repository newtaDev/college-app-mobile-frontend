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
  final CourseSubjectSelectionStates courseSubjectSelectionStates;
  final ApiErrorRes? error;

  const SelectionState({
    this.allClasses = const [],
    this.selectedAllClasses,
    required this.assignedClassesSelectonStates,
    required this.courseSubjectSelectionStates,
    this.error,
  });

  @override
  List<Object?> get props {
    return [
      allClasses,
      selectedAllClasses,
      assignedClassesSelectonStates,
      courseSubjectSelectionStates,
      error,
    ];
  }

  const SelectionState.init()
      : allClasses = const [],
        assignedClassesSelectonStates =
            const AssignedClassesSelectonStates.empty(),
        courseSubjectSelectionStates =
            const CourseSubjectSelectionStates.empty(),
        error = null,
        selectedAllClasses = null;

  SelectionState copyWith({
    List<ClassWithDetails>? allClasses,
    ClassWithDetails? selectedAllClasses,
    AssignedClassesSelectonStates? assignedClassesSelectonStates,
    CourseSubjectSelectionStates? courseSubjectSelectionStates,
    ApiErrorRes? error,
  }) {
    return SelectionState(
      allClasses: allClasses ?? this.allClasses,
      selectedAllClasses: selectedAllClasses ?? this.selectedAllClasses,
      assignedClassesSelectonStates:
          assignedClassesSelectonStates ?? this.assignedClassesSelectonStates,
      courseSubjectSelectionStates:
          courseSubjectSelectionStates ?? this.courseSubjectSelectionStates,
      error: error ?? this.error,
    );
  }

  SelectionState clearSubjects() {
    return SelectionState(
      allClasses: allClasses,
      selectedAllClasses: selectedAllClasses,
      assignedClassesSelectonStates: assignedClassesSelectonStates,
      courseSubjectSelectionStates: const CourseSubjectSelectionStates.empty(),
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

class CourseSubjectSelectionStates extends MyEquatable {
  final CourseSubjectStatus status;
  final List<Subject> courseSubjects;
  final Subject? selectedCourseSubject;
  const CourseSubjectSelectionStates({
    required this.status,
    required this.courseSubjects,
    this.selectedCourseSubject,
  });
  const CourseSubjectSelectionStates.empty()
      : status = CourseSubjectStatus.initial,
        courseSubjects = const [],
        selectedCourseSubject = null;

  CourseSubjectSelectionStates copyWith({
    CourseSubjectStatus? status,
    List<Subject>? courseSubjects,
    Subject? selectedCourseSubject,
  }) {
    return CourseSubjectSelectionStates(
      status: status ?? this.status,
      courseSubjects: courseSubjects ?? this.courseSubjects,
      selectedCourseSubject:
          selectedCourseSubject ?? this.selectedCourseSubject,
    );
  }

  @override
  List<Object?> get props => [status, courseSubjects, selectedCourseSubject];
}
