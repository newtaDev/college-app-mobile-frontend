enum DashboardPageTabs {
  home,
  classRoom,
  profile;

  static DashboardPageTabs? fromName(String name) {
    for (final DashboardPageTabs enumVariant in DashboardPageTabs.values) {
      if (enumVariant.name == name) return enumVariant;
    }
    return null;
  }
}

enum Week {
  monday('MON'),
  tuesday('TUE'),
  wednesday('WED'),
  thursday('THU'),
  friday('FRI'),
  saturday('SAT'),
  sunday('SUN');

  final String value;
  const Week(this.value);

  static Week? fromName(String name) {
    for (final Week enumVariant in Week.values) {
      if (enumVariant.value == name) return enumVariant;
    }
    return null;
  }
}

enum UserType {
  teacher('TEACHER'),
  student('STUDENT'),
  staff('STAFF'),
  principal('PRINCIPAL'),
  admin('ADMIN'),
  superAdmin('SUPER-ADMIN');

  final String value;
  const UserType(this.value);

  static UserType? fromName(String name) {
    for (final UserType enumVariant in UserType.values) {
      if (enumVariant.value == name) return enumVariant;
    }
    return null;
  }
}

enum AnnouncementLayoutType {
  imageWithText('IMAGE_WITH_TEXT'),
  multiImageWithText('MULTI_IMAGE_WITH_TEXT'),
  onlyText('ONLY_TEXT');

  final String value;
  const AnnouncementLayoutType(this.value);

  static AnnouncementLayoutType? fromName(String name) {
    for (final AnnouncementLayoutType enumVariant
        in AnnouncementLayoutType.values) {
      if (enumVariant.value == name) return enumVariant;
    }
    return null;
  }
}

enum AnounceTo {
  students('STUDENTS');

  final String value;
  const AnounceTo(this.value);

  static AnounceTo? fromName(String name) {
    for (final AnounceTo enumVariant in AnounceTo.values) {
      if (enumVariant.value == name) return enumVariant;
    }
    return null;
  }
}
