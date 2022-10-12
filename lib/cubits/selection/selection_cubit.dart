import 'package:bloc/bloc.dart';

import '../../../../../data/models/data_class/class_with_details.dart';
import '../../../../../domain/repository/common_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';
import '../../data/models/data_class/subject_model.dart';
import '../../utils/utils.dart';
import '../user/user_cubit.dart';

part 'selection_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  final UserCubit userCubit;
  final CommonRepository commonRepo;
  SelectionCubit({
    required this.commonRepo,
    required this.userCubit,
  }) : super(const SelectionState.init());

  void getAssignedClassesOfTeacherFromMemory() {
    emit(
      state.copyWith(
        assignedClassesSelectonStates:
            state.assignedClassesSelectonStates.copyWith(
          status: AssignedClassesOfTeacherStatus.success,
          assignedClassesOfTeacher:
              userCubit.state.userAsTeacher?.assignedClasses,
        ),
      ),
    );
  }

  Future<void> getAssignedClassesOfTeacherFromRemote() async {
    emit(
      state.copyWith(
        assignedClassesSelectonStates: state.assignedClassesSelectonStates
            .copyWith(status: AssignedClassesOfTeacherStatus.loading),
      ),
    );
    try {
      final classRes = await commonRepo.getAssignedClassesOfTeacher();
      emit(
        state.copyWith(
          assignedClassesSelectonStates:
              state.assignedClassesSelectonStates.copyWith(
            status: AssignedClassesOfTeacherStatus.success,
            assignedClassesOfTeacher: classRes.responseData,
          ),
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          assignedClassesSelectonStates: state.assignedClassesSelectonStates
              .copyWith(status: AssignedClassesOfTeacherStatus.error),
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Getting classses failed');
      emit(
        state.copyWith(
          assignedClassesSelectonStates: state.assignedClassesSelectonStates
              .copyWith(status: AssignedClassesOfTeacherStatus.error),
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  void getAndSetAssignedSubjectsOfTeacher() {
    emit(
      state.copyWith(
        assignedSubjectSelectionStates:
            state.assignedSubjectSelectionStates.copyWith(
          status: CourseSubjectStatus.success,
          subjects: userCubit.state.userAsTeacher?.assignedSubjects,
        ),
      ),
    );
  }

  Future<void> getSubjectWithDetailsOfCourse(String courseId) async {
    emit(
      state.copyWith(
        assignedSubjectSelectionStates: state.assignedSubjectSelectionStates
            .copyWith(status: CourseSubjectStatus.loading),
      ),
    );
    try {
      final res = await commonRepo.getSubjectsOfCourse(courseId);
      emit(
        state.copyWith(
          assignedSubjectSelectionStates:
              state.assignedSubjectSelectionStates.copyWith(
            status: CourseSubjectStatus.success,
            subjects: res.responseData,
          ),
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          assignedSubjectSelectionStates: state.assignedSubjectSelectionStates
              .copyWith(status: CourseSubjectStatus.error),
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Creating attendance failed');
      emit(
        state
          ..copyWith(
            assignedSubjectSelectionStates: state.assignedSubjectSelectionStates
                .copyWith(status: CourseSubjectStatus.error),
            error: apiErrorRes,
          ),
      );
      rethrow;
    }
  }

  void setSelectedAssignedClass(ClassWithDetails selectedClass) {
    emit(
      state.copyWith(
        assignedClassesSelectonStates:
            state.assignedClassesSelectonStates.copyWith(
          selectedClass: selectedClass,
          totalSem: selectedClass.course?.totalSem,
          selectedSem: selectedClass.currentSem,
        ),
      ),
    );
  }

  void setSelectedAssignedSemester(int selectedSem) {
    emit(
      state.copyWith(
        assignedClassesSelectonStates: state.assignedClassesSelectonStates
            .copyWith(selectedSem: selectedSem),
      ),
    );
  }

  void setSelectedSubject(Subject subject) {
    emit(
      state.copyWith(
        assignedSubjectSelectionStates: state.assignedSubjectSelectionStates
            .copyWith(selectedSubject: subject),
      ),
    );
  }

  void clearSubject() {
    emit(state.clearSubjects());
  }
}
