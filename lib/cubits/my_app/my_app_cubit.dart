import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../config/app_config.dart';
import '../../data/data_source/local/auth_lds.dart';
import '../../domain/repository/profile_repository.dart';
import '../../domain/repository/token_repository.dart';
import '../../utils/utils.dart';
import '../auth/auth_cubit.dart';
import '../my_profile/my_profile_cubit.dart';

part 'my_app_state.dart';

class MyAppCubit extends Cubit<MyAppState> {
  final TokenRepository tokenRepo;
  final MyProfileCubit profileCubit;
  final ProfileRepository profileRepo;
  final AuthLocalDataSource authLds;
  MyAppCubit({
    required this.tokenRepo,
    required this.profileRepo,
    required this.profileCubit,
    required this.authLds,
  }) : super(const MyAppState.init()) {
    _appInit();
  }

  Future<void> _appInit() async {
    emit(state.copyWith(splashStatus: SplashStatus.loading));
    if (!authLds.isLogedIn) {
      await Future<void>.delayed(const Duration(seconds: 3));
      emit(state.copyWith(splashStatus: SplashStatus.neverLogedIn));
      return;
    }

    if (authLds.isRefreshTokenExpired) {
      await authLds.clear();
      emit(state.copyWith(splashStatus: SplashStatus.sessionExpired));
      return;
    }

    try {
      await tokenRepo.reGenerateToken();
      await setUpInitialUserData();
      log('-- Login Success --');
      emit(state.copyWith(splashStatus: SplashStatus.loginSuccess));
    } catch (e) {
      emit(state.copyWith(splashStatus: SplashStatus.failed));
      rethrow;
    }
  }

  Future<void> setUpInitialUserData() async {
    try {
      if (authLds.userId == null || authLds.userType == null) {
        await authLds.clear();
        throw Exception('[userId] | [userType] should not be null');
      }

      (await profileRepo.getProfileData(
        id: authLds.userId!,
        userType: authLds.userType!,
      ))
          .fold(
        (res) => profileCubit.setProfileData(res.responseData!),
        (error) => throw error,
      );
    } catch (e) {
      rethrow;
    }
  }
}
