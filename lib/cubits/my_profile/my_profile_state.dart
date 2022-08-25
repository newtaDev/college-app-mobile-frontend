part of 'my_profile_cubit.dart';

class MyProfileState extends MyEquatable {
  final UserProfileData myProfile;
  const MyProfileState({
    required this.myProfile,
  });

  MyProfileState.init() : myProfile = UserProfileData.empty();

  UserType get userType => myProfile.userType;

  bool get isTeacher => userType == UserType.teacher;

  bool get isStudent => userType == UserType.student;

  TeacherProfileData? get profileAsTeacher {
    if (userType == UserType.teacher) return myProfile as TeacherProfileData;
    return null;
  }

  StudentProfileData? get profileAsStudent {
    if (userType == UserType.student) return myProfile as StudentProfileData;
    return null;
  }

  @override
  List<Object?> get props => [myProfile];

  MyProfileState copyWith({
    UserProfileData? myProfile,
  }) {
    return MyProfileState(
      myProfile: myProfile ?? this.myProfile,
    );
  }
}
