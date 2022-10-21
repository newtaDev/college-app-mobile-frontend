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

  Future<void> getAccessibleClassesOfTeacher() async {
    emit(
      state.copyWith(
        accessibleClassesStates: state.accessibleClassesStates
            .copyWith(status: SelectionStatus.loading),
      ),
    );
    try {
      final classRes = await commonRepo.getAssignedClassesOfTeacher();
      emit(
        state.copyWith(
          accessibleClassesStates: state.accessibleClassesStates.copyWith(
            status: SelectionStatus.success,
            classes: classRes.responseData,
          ),
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          accessibleClassesStates: state.accessibleClassesStates
              .copyWith(status: SelectionStatus.error),
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Getting classses failed');
      emit(
        state.copyWith(
          accessibleClassesStates: state.accessibleClassesStates
              .copyWith(status: SelectionStatus.error),
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAccessibleSubjectsOfTeacher() async {
    emit(
      state.copyWith(
        accessibleSubjectStates: state.accessibleSubjectStates
            .copyWith(status: SelectionStatus.loading),
      ),
    );
    try {
      final subjectRes = await commonRepo
          .getAssignedSubjectsOfTeacher(userCubit.state.userAsTeacher!.id);
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates.copyWith(
            status: SelectionStatus.success,
            subjects: subjectRes.responseData,
          ),
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates
              .copyWith(status: SelectionStatus.error),
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Getting classses failed');
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates
              .copyWith(status: SelectionStatus.error),
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAccessibleSubjectsOfStudents() async {
    emit(
      state.copyWith(
        accessibleSubjectStates: state.accessibleSubjectStates
            .copyWith(status: SelectionStatus.loading),
      ),
    );
    try {
      final subjectRes = await commonRepo
          .getSubjectsOfClass(userCubit.state.userAsStudent!.classId);
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates.copyWith(
            status: SelectionStatus.success,
            subjects: subjectRes.responseData,
          ),
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates
              .copyWith(status: SelectionStatus.error),
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Getting classses failed');
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates
              .copyWith(status: SelectionStatus.error),
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getSubjectWithDetailsOfCourse(String courseId) async {
    emit(
      state.copyWith(
        accessibleSubjectStates: state.accessibleSubjectStates
            .copyWith(status: SelectionStatus.loading),
      ),
    );
    try {
      final res = await commonRepo.getSubjectsOfCourse(courseId);
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates.copyWith(
            status: SelectionStatus.success,
            subjects: res.responseData,
          ),
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          accessibleSubjectStates: state.accessibleSubjectStates
              .copyWith(status: SelectionStatus.error),
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Creating attendance failed');
      emit(
        state
          ..copyWith(
            accessibleSubjectStates: state.accessibleSubjectStates
                .copyWith(status: SelectionStatus.error),
            error: apiErrorRes,
          ),
      );
      rethrow;
    }
  }

  void setSelectedAssignedClass(ClassWithDetails selectedClass) {
    emit(
      state.copyWith(
        accessibleClassesStates: state.accessibleClassesStates.copyWith(
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
        accessibleClassesStates:
            state.accessibleClassesStates.copyWith(selectedSem: selectedSem),
      ),
    );
  }

  void setSelectedSubject(Subject subject) {
    emit(
      state.copyWith(
        accessibleSubjectStates:
            state.accessibleSubjectStates.copyWith(selectedSubject: subject),
      ),
    );
  }

  void clearSubject() {
    emit(state.clearSubjects());
  }
}
