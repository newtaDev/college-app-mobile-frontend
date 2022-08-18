import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../config/app_config.dart';
import '../../data/data_source/local/auth_lds.dart';
import '../../domain/repository/token_repository.dart';

part 'my_app_state.dart';

class MyAppCubit extends Cubit<MyAppState> {
  final TokenRepository tokenRepo;
  MyAppCubit({
    required this.tokenRepo,
  }) : super(const MyAppState.init()) {
    _splashInit();
  }

  Future<void> _splashInit() async {
    emit(state.copyWith(splashStatus: SplashStatus.loading));
    final authLds = getIt<AuthLocalDataSource>();
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
      //TODO: Get profile details from user id
      log('-- Login Success --');
      emit(state.copyWith(splashStatus: SplashStatus.loginSuccess));
    } catch (e) {
      emit(state.copyWith(splashStatus: SplashStatus.failed));
      rethrow;
    }
  }

  Future<void> getUserData() {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
