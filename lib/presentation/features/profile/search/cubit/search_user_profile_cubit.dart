import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/user_entity.dart';
import '../../../../../domain/repository/profile_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'search_user_profile_state.dart';

class SearchUserProfileCubit extends Cubit<SearchUserProfileState> {
  final ProfileRepository profileRepo;
  SearchUserProfileCubit({required this.profileRepo})
      : super(const SearchUserProfileState.init());

  Future<void> searchUserProfiles({required String searchText}) async {
    emit(state.copyWith(status: SearchUserProfileStatus.loading));
    try {
      final res = await profileRepo.searchUserProfiles(searchText: searchText);
      emit(
        state.copyWith(
          status: SearchUserProfileStatus.success,
          searchResults: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: SearchUserProfileStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Searching user profile failed');
      emit(
        state.copyWith(
          status: SearchUserProfileStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
