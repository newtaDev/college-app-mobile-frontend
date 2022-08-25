import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/auth_entitie.dart';
import '../../../../../domain/repository/auth_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepo;
  SignUpCubit({required this.authRepo}) : super(const SignUpInitialState());

  Future<void> signUpUser(SignUpReq req) async {
    emit(const SignUpLoadingState());
    try {
      final res = await authRepo.signUpUser(req);
      emit(SignUpSuccessState(data: res));
    } on ApiErrorRes catch (apiError) {
      emit(SignUpErrorState(error: apiError));
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
