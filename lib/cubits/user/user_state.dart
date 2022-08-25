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

  TeacherUser? get userAsTeacher {
    if (userType == UserType.teacher) return userDetails as TeacherUser;
    return null;
  }

  StudentUser? get userAsStudent {
    if (userType == UserType.student) return userDetails as StudentUser;
    return null;
  }

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
