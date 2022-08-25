import 'package:bloc/bloc.dart';

import '../../data/data_source/local/auth_lds.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../../shared/global/enums.dart';
import '../../utils/utils.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  final AuthLocalDataSource authLds;
  final ProfileRepository profileRepo;
  MyProfileCubit({required this.authLds, required this.profileRepo})
      : super(MyProfileState.init());

  void getMyProfile() {}

  void setProfileData(UserProfileData userProfileData) {
    emit(state.copyWith(myProfile: userProfileData));
  }

  Future<void> setUpInitialUserData() async {
    try {
      if (authLds.userId == null || authLds.userType == null) {
        await authLds.clear();
        throw Exception('[userId] | [userType] should not be null');
      }

      final res = await profileRepo.getProfileData(
        id: authLds.userId!,
        userType: authLds.userType!,
      );
      setProfileData(res.responseData!);
    } catch (e) {
      rethrow;
    }
  }
}
