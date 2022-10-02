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
    emit(
      state.copyWith(
        allStatus: myClassOnly ? null : ViewAnouncementStatus.loading,
        myStatus: myClassOnly ? ViewAnouncementStatus.loading : null,
      ),
    );
    try {
      final res = await anouncementRepo.getAnouncementForStudents(
        anounceToClassId: userCubit.state.userAsStudent!.classId,
        showMyClassesOnly: myClassOnly,
      );
      emit(
        state.copyWith(
          allStatus: myClassOnly ? null : ViewAnouncementStatus.success,
          myStatus: myClassOnly ? ViewAnouncementStatus.success : null,
          allAnouncementModels: myClassOnly ? null : res.responseData,
          myAnouncementModels: myClassOnly ? res.responseData : null,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          allStatus: myClassOnly ? null : ViewAnouncementStatus.error,
          myStatus: myClassOnly ? ViewAnouncementStatus.error : null,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          allStatus: myClassOnly ? null : ViewAnouncementStatus.error,
          myStatus: myClassOnly ? ViewAnouncementStatus.error : null,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAnouncementForTeachers({
    bool showAnouncementsCreatedByMe = false,
  }) async {
    emit(
      state.copyWith(
        allStatus:
            showAnouncementsCreatedByMe ? null : ViewAnouncementStatus.loading,
        myStatus:
            showAnouncementsCreatedByMe ? ViewAnouncementStatus.loading : null,
      ),
    );
    try {
      final res = await anouncementRepo.getAnouncementForTeachers(
        teacherId: userCubit.state.userAsTeacher!.id,
        showAnouncementsCreatedByMe: showAnouncementsCreatedByMe,
      );
      emit(
        state.copyWith(
          allStatus: showAnouncementsCreatedByMe
              ? null
              : ViewAnouncementStatus.success,
          myStatus: showAnouncementsCreatedByMe
              ? ViewAnouncementStatus.success
              : null,
          allAnouncementModels:
              showAnouncementsCreatedByMe ? null : res.responseData,
          myAnouncementModels:
              showAnouncementsCreatedByMe ? res.responseData : null,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          allStatus:
              showAnouncementsCreatedByMe ? null : ViewAnouncementStatus.error,
          myStatus:
              showAnouncementsCreatedByMe ? ViewAnouncementStatus.error : null,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          allStatus:
              showAnouncementsCreatedByMe ? null : ViewAnouncementStatus.error,
          myStatus:
              showAnouncementsCreatedByMe ? ViewAnouncementStatus.error : null,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
