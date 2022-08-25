part of profile_entity;

class UserProfileData extends MyEquatable {
  final String name;
  final String id;
  final String email;
  final String collegeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserType userType;
  const UserProfileData({
    required this.name,
    required this.id,
    required this.email,
    required this.collegeId,
    required this.createdAt,
    required this.updatedAt,
    required this.userType,
  });

  UserProfileData.empty()
      : collegeId = '',
        createdAt = DateTime.now(),
        email = '',
        id = '',
        name = '',
        updatedAt = DateTime.now(),
        userType = UserType.superAdmin;

  @override
  List<Object> get props {
    return [
      name,
      id,
      email,
      collegeId,
      createdAt,
      updatedAt,
      userType,
    ];
  }
}
