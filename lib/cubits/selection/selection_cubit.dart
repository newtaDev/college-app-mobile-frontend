import 'package:bloc/bloc.dart';

import '../../../../../data/models/data_class/class_with_details.dart';
import '../../../../../domain/repository/common_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../shared/extensions/extentions.dart';
import '../../../../../utils/utils.dart';
import '../../data/models/data_class/subject_model.dart';

part 'selection_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  final CommonRepository commonRepo;
  SelectionCubit({
    required this.commonRepo,
  }) : super(const SelectionState.init());

  Future<void> getClassesWithDetails() async {
    emit(state.copyWith(classAndSemStatus: SemAndClassStatus.loading));
    try {
      final classRes = await commonRepo.getAssignedClassesOfTeacher();
      if (state.selectedClass != null) {
        final _selectedClass = classRes.responseData?.firstWhereSafe(
          (element) => state.selectedClass!.id! == element.id,
        );
        if (_selectedClass == null ||
            state.selectedSem == null ||
            state.selectedSem! > _selectedClass.course!.totalSem!) {
          emit(const SelectionState.init());
        }
      }
      emit(
        state.copyWith(
          classAndSemStatus: SemAndClassStatus.success,
          classes: classRes.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          classAndSemStatus: SemAndClassStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Getting classses failed');
      emit(
        state.copyWith(
          classAndSemStatus: SemAndClassStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getSubjectWithDetailsOfCourse(String courseId) async {
    emit(state.copyWith(subjectStatus: SubjectStatus.loading));
    try {
      final res = await commonRepo.getSubjectsOfCourse(courseId);
      emit(
        state.copyWith(
          subjectStatus: SubjectStatus.success,
          subjects: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          subjectStatus: SubjectStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Creating attendance failed');
      emit(
        state.copyWith(
          subjectStatus: SubjectStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  void setSelectedClass(ClassWithDetails selectedClass) {
    emit(
      state.copyWith(
        selectedClass: selectedClass,
        totalSem: selectedClass.course?.totalSem,
        selectedSem: selectedClass.currentSem,
      ),
    );
  }

  void setSelectedSemester(int selectedSem) {
    emit(state.copyWith(selectedSem: selectedSem));
  }

  void setSelectedSubject(Subject subject) {
    emit(state.copyWith(selectedSubject: subject));
  }

  void clearSubject() {
    emit(state.clearSubjects());
  }
}
