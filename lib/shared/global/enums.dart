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
