import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/profile_entity.dart';
import '../../shared/global/enums.dart';
import '../../utils/utils.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(MyProfileState.init());

  void getMyProfile() {}
  
  void setProfileData(UserProfileData userProfileData) {
    emit(state.copyWith(myProfile: userProfileData));
  }
}
