import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/auth_entitie.dart';
import '../../domain/repository/auth_repository.dart';
import '../../shared/errors/api_errors.dart';
import '../../utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepo;
  AuthCubit({required this.authRepo}) : super(const AuthState.init());

  Future<void> singInUser(SignInReq req) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      (await authRepo.signInUser(req)).fold(
        (authRes) {
          emit(state.copyWith(status: AuthStatus.logedIn, authRes: authRes));
        },
        (error) {
          emit(state.copyWith(status: AuthStatus.failure, error: error));
        },
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'User Login failed');
      emit(state.copyWith(status: AuthStatus.failure, error: apiErrorRes));
      rethrow;
    }
  }

  bool isValidFormInput(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }

  Future<void> logoutUser() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepo.logoutUser();
      emit(state.copyWith(status: AuthStatus.logedOut));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure));
      rethrow;
    }
  }
}
