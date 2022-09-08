part of 'user_cubit.dart';

class UserState extends MyEquatable {
  final UserDetails userDetails;
  const UserState({
    required this.userDetails,
  });

  UserState.init() : userDetails = UserDetails.empty();

  UserType get userType => userDetails.userType;

  bool get isTeacher => userType == UserType.teacher;

  bool get isStudent => userType == UserType.student;

  TeacherUser? get userAsTeacher => userDetails.asTeacher;

  StudentUser? get userAsStudent => userDetails.asStudent;

  @override
  List<Object?> get props => [userDetails];

  UserState copyWith({
    UserDetails? userDetails,
  }) {
    return UserState(
      userDetails: userDetails ?? this.userDetails,
    );
  }
}
