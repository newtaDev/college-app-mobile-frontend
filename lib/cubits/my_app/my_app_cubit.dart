import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../data/data_source/local/auth_lds.dart';
import '../../domain/repository/token_repository.dart';
import '../../utils/utils.dart';
import '../my_profile/my_profile_cubit.dart';

part 'my_app_state.dart';

class MyAppCubit extends Cubit<MyAppState> {
  final TokenRepository tokenRepo;
  final MyProfileCubit profileCubit;
  final AuthLocalDataSource authLds;
  MyAppCubit({
    required this.tokenRepo,
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
      await profileCubit.setUpInitialUserData();
      log('-- Login Success --');
      emit(state.copyWith(splashStatus: SplashStatus.loginSuccess));
    } catch (e) {
      emit(state.copyWith(splashStatus: SplashStatus.failed));
      rethrow;
    }
  }
}
