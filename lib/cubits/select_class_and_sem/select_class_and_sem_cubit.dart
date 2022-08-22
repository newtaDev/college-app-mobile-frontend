import 'package:bloc/bloc.dart';

import '../../../../../data/models/data_class/class_with_details.dart';
import '../../../../../domain/repository/common_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../shared/extensions/extentions.dart';
import '../../../../../utils/utils.dart';

part 'select_class_and_sem_state.dart';

class SelectClassAndSemCubit extends Cubit<SelectClassAndSemState> {
  final CommonRepository commonRepo;
  SelectClassAndSemCubit({
    required this.commonRepo,
  }) : super(const SelectClassAndSemState.init());

  Future<void> getClassesWithDetails() async {
    emit(state.copyWith(status: SelectClassAndSemStatus.loading));
    try {
      (await commonRepo.getClassesWithDetails()).fold(
        (data) {
          if (state.selectedClass != null) {
            final _selectedClass = data.responseData?.firstWhereSafe(
              (element) => state.selectedClass!.id! == element.id,
            );
            if (_selectedClass == null ||
                state.selectedSem == null ||
                state.selectedSem! > _selectedClass.course!.totalSem!) {
              emit(const SelectClassAndSemState.init());
            }
          }
          emit(
            state.copyWith(
              status: SelectClassAndSemStatus.success,
              classes: data.responseData,
            ),
          );
        },
        (error) {
          emit(
            state.copyWith(
              status: SelectClassAndSemStatus.error,
              error: error,
            ),
          );
        },
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Getting classses failed');
      emit(
        state.copyWith(
          status: SelectClassAndSemStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  void selectClass(ClassWithDetails selectedClass) {
    emit(
      state.copyWith(
        selectedClass: selectedClass,
        totalSem: selectedClass.course?.totalSem,
        selectedSem: selectedClass.currentSem,
      ),
    );
  }

  void selectSem(int selectedSem) {
    emit(state.copyWith(selectedSem: selectedSem));
  }
}
