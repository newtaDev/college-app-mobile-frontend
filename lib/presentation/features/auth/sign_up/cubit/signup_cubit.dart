import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/auth_entitie.dart';
import '../../../../../domain/repository/auth_repository.dart';
import '../../../../../shared/errors/api_errors.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepo;
  SignUpCubit({required this.authRepo}) : super(const SignUpInitialState());

  Future<void> signUpUser(SignUpReq req) async {
    emit(const SignUpLoadingState());
    try {
      (await authRepo.signUpUser(req)).fold(
        (authRes) => emit(SignUpSuccessState(data: authRes)),
        (error) => emit(SignUpErrorState(error: error)),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: e.toString());
      emit(SignUpErrorState(error: apiErrorRes));
      throw apiErrorRes;
    }
  }

  bool isValidInput(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }
}
