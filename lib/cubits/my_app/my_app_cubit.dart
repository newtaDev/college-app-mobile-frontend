import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../data/data_source/local/auth_lds.dart';
import '../../domain/repository/token_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../../utils/utils.dart';
import '../selection/selection_cubit.dart';
import '../user/user_cubit.dart';

part 'my_app_state.dart';

class MyAppCubit extends Cubit<MyAppState> {
  final TokenRepository tokenRepo;
  final UserCubit userCubit;
  final SelectionCubit selectionCubit;
  final AuthLocalDataSource authLds;
  MyAppCubit({
    required this.tokenRepo,
    required this.userCubit,
    required this.selectionCubit,
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
      await userCubit.setUpInitialUserData();
      log('-- Login Success --');
      if (userCubit.state.isTeacher) {
        await selectionCubit.getAccessibleSubjectsOfTeacher();
      }
      if (userCubit.state.isStudent) {
        await selectionCubit.getAccessibleSubjectsOfStudents();
      }
      emit(state.copyWith(splashStatus: SplashStatus.loginSuccess));
    } on ApiErrorRes catch (_) {
      emit(state.copyWith(splashStatus: SplashStatus.invalidUser));
    } catch (e) {
      emit(state.copyWith(splashStatus: SplashStatus.failed));
      rethrow;
    }
  }

  void refreshPage(PageRefresherStatus status) {
    emit(state.copyWith(pageRefresherStatus: status));
  }

  void setRefreshStatusToInit() {
    emit(state.copyWith(pageRefresherStatus: PageRefresherStatus.initial));
  }
}
