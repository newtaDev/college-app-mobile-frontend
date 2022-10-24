import '../../shared/global/enums.dart';

enum Routes {
  splashScreen,
  dashboardScreen,
  signInScreen,
  attendanceClassReportScreen,
  attendanceSubjectReportScreen,
  viewAttendanceScreen,
  createAttendanceScreen,
  updateAttendanceScreen,
  reportsScreen,
  signUpScreen,
  qrViewerScreen,
  classTimeTable,
  qrScannerScreen,
  profileScreen,
  myProfileEditScreen,
  createAnnouncementFormatsScreen,
  createAnnouncementScreen,
  imageViewerScreen,
  searchProfileScreen,
  subjectResourcesScreen,
  subjectResourceDetailsScreen,
  downloadsScreen,

  /// Showcase screens
  schowcaseThemeAndWidgetsScreen,
  showcaseTypographyScreen,
  showcaseColorsScreen,
  showcaseWidgetsScreen;

  static Routes? fromName(String name) {
    for (final Routes route in Routes.values) {
      if (route.name == name) return route;
    }
    return null;
  }
}

class RouteParams {
  static DashboardPageTabs selectedDashboardTab = DashboardPageTabs.home;

  static Map<String, String> get withDashboard =>
      {'tab_name': selectedDashboardTab.name};
}
