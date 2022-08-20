part of profile_entity;

class UserProfileData extends MyEquatable {
  final String name;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserType userType;
  const UserProfileData({
    required this.name,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userType,
  });

  @override
  List<Object> get props {
    return [
      name,
      id,
      createdAt,
      updatedAt,
      userType,
    ];
  }
}