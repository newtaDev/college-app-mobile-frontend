class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.username,
    required this.slogan,
    required this.description,
    required this.profilePic,
    required this.bannerPic,
    required this.tags,
  });

  String id;
  String name;
  String username;
  String slogan;
  String description;
  String profilePic;
  String bannerPic;
  List<String> tags;
}
