import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../domain/entities/anouncement_entity.dart';
import '../../../../../domain/repository/anouncement_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'view_anouncement_state.dart';

class ViewAnouncementCubit extends Cubit<ViewAnouncementState> {
  final AnouncementRepository anouncementRepo;
  final UserCubit userCubit;
  ViewAnouncementCubit({
    required this.anouncementRepo,
    required this.userCubit,
  }) : super(const ViewAnouncementState.init());

  Future<void> getAnouncementForStudents({bool myClassOnly = false}) async {
    emit(state.copyWith(status: ViewAnouncementStatus.loading));
    try {
      final res = await anouncementRepo.getAnouncementForStudents(
        anounceToClassId: userCubit.state.userAsStudent!.classId,
        showMyClassesOnly: myClassOnly,
      );
      emit(
        state.copyWith(
          status: ViewAnouncementStatus.success,
          anouncementModels: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ViewAnouncementStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          status: ViewAnouncementStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAnouncementForTeachers({
    bool showAnouncementsCreatedByMe = false,
  }) async {
    emit(state.copyWith(status: ViewAnouncementStatus.loading));
    try {
      final res = await anouncementRepo.getAnouncementForTeachers(
        teacherId: userCubit.state.userAsTeacher!.id,
        showAnouncementsCreatedByMe: showAnouncementsCreatedByMe,
      );
      emit(
        state.copyWith(
          status: ViewAnouncementStatus.success,
          anouncementModels: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ViewAnouncementStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          status: ViewAnouncementStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
