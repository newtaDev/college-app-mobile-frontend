part of user_entity;

class UserDetails extends MyEquatable {
  final String name;
  final String id;
  final String? email;
  final String? username;
  final bool isProfileCompleted;
  final String collegeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserType userType;
  
  const UserDetails({
    required this.name,
    required this.id,
    this.email,
    this.username,
    required this.isProfileCompleted,
    required this.collegeId,
    required this.createdAt,
    required this.updatedAt,
    required this.userType,
  });

  UserDetails.empty()
      : collegeId = '',
        email = '',
        id = '',
        name = '',
        username = '',
        isProfileCompleted = false,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        userType = UserType.superAdmin;

  @override
  List<Object?> get props {
    return [
      name,
      id,
      email,
      username,
      isProfileCompleted,
      collegeId,
      createdAt,
      updatedAt,
      userType,
    ];
  }
}
