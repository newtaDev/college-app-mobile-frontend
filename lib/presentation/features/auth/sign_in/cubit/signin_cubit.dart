import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/auth_entitie.dart';
import '../../../../../domain/use_cases/auth_use_case.dart';
import '../../../../../shared/errors/api_errors.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthUseCase useCase;
  SignInCubit({required this.useCase}) : super(const SignInInitialState());

  Future<void> singInUser(SignInReq req) async {
    emit(const SignInLoadingState());
    try {
      (await useCase.authRepo.signInUser(req)).fold(
        (authRes) => emit(SignInSuccessState(data: authRes)),
        (error) => emit(SignInErrorState(error: error)),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: e.toString());
      emit(SignInErrorState(error: apiErrorRes));
      rethrow;
    }
  }

  bool isValidInput(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }
}
