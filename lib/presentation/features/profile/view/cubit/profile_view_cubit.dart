import 'package:bloc/bloc.dart';

import '../../../../../../cubits/user/user_cubit.dart';
import '../../../../../../domain/entities/user_entity.dart';
import '../../../../../../domain/repository/profile_repository.dart';
import '../../../../../../shared/errors/api_errors.dart';
import '../../../../../../shared/global/enums.dart';
import '../../../../../../utils/utils.dart';

part 'profile_view_state.dart';

class ProfileViewCubit extends Cubit<ProfileViewState> {
  final UserCubit userCubit;
  final ProfileRepository profileRepo;
  ProfileViewCubit({required this.userCubit, required this.profileRepo})
      : super(const ProfileViewState.init());

  void setDataIfMyProfile(String userId) {
    final _user = userCubit.state.userDetails;
    if (userId == _user.id) {
      emit(
        state.copyWith(
          userDetails: _user,
          status: ProfileViewStatus.success,
        ),
      );
    }
  }

  Future<void> getProfileDetails({
    required String userId,
    required UserType userType,
  }) async {
    emit(state.copyWith(status: ProfileViewStatus.loading));
    try {
      final res = await profileRepo.getProfile(
        userId: userId,
        userType: userType,
      );
      emit(
        state.copyWith(
          status: ProfileViewStatus.success,
          userDetails: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ProfileViewStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching profile failed');
      emit(
        state.copyWith(
          status: ProfileViewStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
