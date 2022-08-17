enum DashboardPageTabs {
  home,
  profile,
  settings;

  static DashboardPageTabs? fromName(String name) {
    for (final DashboardPageTabs enumVariant in DashboardPageTabs.values) {
      if (enumVariant.name == name) return enumVariant;
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
