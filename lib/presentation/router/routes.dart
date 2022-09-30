import 'package:flutter/material.dart';

import '../../shared/global/enums.dart';
import 'app_router.dart';

enum Routes {
  splashScreen,
  dashboardScreen,
  signInScreen,
  selectClassAndSemScreen,
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
  createAnouncementFormatsScreen,
  createAnouncementScreen,

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
