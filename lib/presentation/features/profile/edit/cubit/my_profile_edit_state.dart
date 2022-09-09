part of 'my_profile_edit_cubit.dart';

enum MyProfileEditStatus { initial, loading, success, error }

enum FieldValidationStatus { initial, loading, success, error }

extension MyProfileEditStatusX on Enum {
  bool get isInitial => name == 'initial';
  bool get isSuccess => name == 'success';
  bool get isError => name == 'error';
  bool get isLoading => name == 'loading';
}

class MyProfileEditState extends Equatable {
  final UserDetails userDetails;
  final MyProfileEditStatus editProfileStatus;
  final FieldValidationStatus usernameStatus;
  final ApiErrorRes? usernameError;
  final FieldValidationStatus emailStatus;
  final ApiErrorRes? emailError;
  final ApiErrorRes? editProfileError;

  const MyProfileEditState({
    required this.userDetails,
    required this.editProfileStatus,
    required this.usernameStatus,
    required this.usernameError,
    required this.emailStatus,
    required this.emailError,
    required this.editProfileError,
  });
  MyProfileEditState.init()
      : userDetails = UserDetails.empty(),
        usernameError = null,
        emailError = null,
        editProfileError = null,
        editProfileStatus = MyProfileEditStatus.initial,
        usernameStatus = FieldValidationStatus.initial,
        emailStatus = FieldValidationStatus.initial;

  @override
  List<Object?> get props {
    return [
      userDetails,
      usernameError,
      emailError,
      editProfileError,
      editProfileStatus,
      usernameStatus,
      emailStatus,
    ];
  }

  MyProfileEditState copyWith({
    UserDetails? userDetails,
    MyProfileEditStatus? editProfileStatus,
    FieldValidationStatus? usernameStatus,
    ApiErrorRes? usernameError,
    FieldValidationStatus? emailStatus,
    ApiErrorRes? emailError,
    ApiErrorRes? editProfileError,
  }) {
    return MyProfileEditState(
      userDetails: userDetails ?? this.userDetails,
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      usernameError: usernameError ?? this.usernameError,
      emailStatus: emailStatus ?? this.emailStatus,
      emailError: emailError ?? this.emailError,
      editProfileError: editProfileError ?? this.editProfileError,
    );
  }
}
