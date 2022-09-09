import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../cubits/user/user_cubit.dart';
import '../../../../../../domain/entities/user_entity.dart';
import '../../../../../../domain/repository/profile_repository.dart';
import '../../../../../../shared/errors/api_errors.dart';
import '../../../../../../shared/global/enums.dart';

part 'my_profile_edit_state.dart';

class MyProfileEditCubit extends Cubit<MyProfileEditState> {
  final ProfileRepository profileRepo;
  final UserCubit userCubit;
  MyProfileEditCubit({required this.profileRepo, required this.userCubit})
      : super(MyProfileEditState.init());

  void setInitialData(UserDetails user) {
    emit(state.copyWith(userDetails: user));
  }

  void setEditedStudentUserData(StudentUser? student) {
    emit(state.copyWith(userDetails: student));
  }

  void setEditedTeacherUserData(TeacherUser? teacher) {
    emit(state.copyWith(userDetails: teacher));
  }

  Future<void> updateStudentProfile(StudentUser student) async {
    emit(state.copyWith(editProfileStatus: MyProfileEditStatus.loading));
    try {
      final res = await profileRepo.updateStudentProfile(
        student.copyWith(isProfileCompleted: true),
      );

      /// updates userDetails in user cubit
      userCubit.setUserData(res.responseData);
      emit(state.copyWith(editProfileStatus: MyProfileEditStatus.success));
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          editProfileStatus: MyProfileEditStatus.error,
          editProfileError: apiError,
        ),
      );
    } catch (e) {
      final apiError = ApiErrorRes(devMessage: 'Editing Profile failed');
      emit(
        state.copyWith(
          editProfileStatus: MyProfileEditStatus.error,
          editProfileError: apiError,
        ),
      );
      rethrow;
    }
  }

  Future<void> updateTeacherProfile(TeacherUser teacher) async {
    emit(state.copyWith(editProfileStatus: MyProfileEditStatus.loading));
    try {
      final res = await profileRepo.updateTeacherProfile(
        teacher.copyWith(isProfileCompleted: true),
      );

      /// updates userDetails in user cubit
      userCubit.setUserData(res.responseData);
      emit(state.copyWith(editProfileStatus: MyProfileEditStatus.success));
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          editProfileStatus: MyProfileEditStatus.error,
          editProfileError: apiError,
        ),
      );
    } catch (e) {
      final apiError = ApiErrorRes(devMessage: 'Editing Profile failed');
      emit(
        state.copyWith(
          editProfileStatus: MyProfileEditStatus.error,
          editProfileError: apiError,
        ),
      );
      rethrow;
    }
  }

  Future<void> checkUsernameExists(
    String username, {
    String? orgUsername,
  }) async {
    if (username == orgUsername) {
      return emit(
        state.copyWith(usernameStatus: FieldValidationStatus.initial),
      );
    }
    emit(state.copyWith(usernameStatus: FieldValidationStatus.loading));
    try {
      await profileRepo.checkUsernameExists(username);
      emit(state.copyWith(usernameStatus: FieldValidationStatus.success));
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          usernameStatus: FieldValidationStatus.error,
          usernameError: apiError,
        ),
      );
    } catch (e) {
      final apiError = ApiErrorRes(message: 'Internal server error');
      emit(
        state.copyWith(
          usernameStatus: FieldValidationStatus.error,
          usernameError: apiError,
        ),
      );
      rethrow;
    }
  }

  Future<void> checkEmailExists(String email, {String? orgEmail}) async {
    if (orgEmail == email) {
      return emit(state.copyWith(emailStatus: FieldValidationStatus.initial));
    }
    emit(state.copyWith(emailStatus: FieldValidationStatus.loading));
    try {
      await profileRepo.checkEmailExists(email);
      emit(state.copyWith(emailStatus: FieldValidationStatus.success));
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          emailStatus: FieldValidationStatus.error,
          emailError: apiError,
        ),
      );
    } catch (e) {
      final apiError = ApiErrorRes(message: 'Internal server error');
      emit(
        state.copyWith(
          emailStatus: FieldValidationStatus.error,
          emailError: apiError,
        ),
      );
      rethrow;
    }
  }
}
