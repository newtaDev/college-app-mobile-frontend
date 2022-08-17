import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/auth_entitie.dart';
import '../../domain/use_cases/auth_use_case.dart';
import '../../shared/errors/api_errors.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase usecase;
  AuthCubit({required this.usecase}) : super(const AuthState.init());

  Future<void> singInUser(SignInReq req) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      (await usecase.authRepo.signInUser(req)).fold(
        (authRes) {
          emit(state.copyWith(status: AuthStatus.success, authRes: authRes));
        },
        (error) {
          emit(state.copyWith(status: AuthStatus.failure, error: error));
        },
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: e.toString());
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
      await usecase.authRepo.logoutUser();
    } catch (e) {
      rethrow;
    }
  }
}
