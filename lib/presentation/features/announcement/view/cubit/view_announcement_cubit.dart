import 'package:bloc/bloc.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../domain/entities/announcement_entity.dart';
import '../../../../../domain/repository/announcement_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'view_announcement_state.dart';

class ViewAnnouncementCubit extends Cubit<ViewAnnouncementState> {
  final AnnouncementRepository announcementRepo;
  final UserCubit userCubit;
  ViewAnnouncementCubit({
    required this.announcementRepo,
    required this.userCubit,
  }) : super(const ViewAnnouncementState.init());

  Future<void> getAnnouncementForStudents({bool myClassOnly = false}) async {
    emit(
      state.copyWith(
        allStatus: myClassOnly ? null : ViewAnnouncementStatus.loading,
        myStatus: myClassOnly ? ViewAnnouncementStatus.loading : null,
      ),
    );
    try {
      final res = await announcementRepo.getAnnouncementForStudents(
        anounceToClassId: userCubit.state.userAsStudent!.classId,
        showMyClassesOnly: myClassOnly,
      );
      emit(
        state.copyWith(
          allStatus: myClassOnly ? null : ViewAnnouncementStatus.success,
          myStatus: myClassOnly ? ViewAnnouncementStatus.success : null,
          allAnnouncementModels: myClassOnly ? null : res.responseData,
          myAnnouncementModels: myClassOnly ? res.responseData : null,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          allStatus: myClassOnly ? null : ViewAnnouncementStatus.error,
          myStatus: myClassOnly ? ViewAnnouncementStatus.error : null,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          allStatus: myClassOnly ? null : ViewAnnouncementStatus.error,
          myStatus: myClassOnly ? ViewAnnouncementStatus.error : null,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAnnouncementForTeachers({
    bool showAnnouncementsCreatedByMe = false,
  }) async {
    emit(
      state.copyWith(
        allStatus: showAnnouncementsCreatedByMe
            ? null
            : ViewAnnouncementStatus.loading,
        myStatus: showAnnouncementsCreatedByMe
            ? ViewAnnouncementStatus.loading
            : null,
      ),
    );
    try {
      final res = await announcementRepo.getAnnouncementForTeachers(
        teacherId: userCubit.state.userAsTeacher!.id,
        showAnnouncementsCreatedByMe: showAnnouncementsCreatedByMe,
      );
      emit(
        state.copyWith(
          allStatus: showAnnouncementsCreatedByMe
              ? null
              : ViewAnnouncementStatus.success,
          myStatus: showAnnouncementsCreatedByMe
              ? ViewAnnouncementStatus.success
              : null,
          allAnnouncementModels:
              showAnnouncementsCreatedByMe ? null : res.responseData,
          myAnnouncementModels:
              showAnnouncementsCreatedByMe ? res.responseData : null,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          allStatus: showAnnouncementsCreatedByMe
              ? null
              : ViewAnnouncementStatus.error,
          myStatus: showAnnouncementsCreatedByMe
              ? ViewAnnouncementStatus.error
              : null,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          allStatus: showAnnouncementsCreatedByMe
              ? null
              : ViewAnnouncementStatus.error,
          myStatus: showAnnouncementsCreatedByMe
              ? ViewAnnouncementStatus.error
              : null,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
