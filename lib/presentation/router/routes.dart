import 'package:flutter/material.dart';

import '../../shared/global/enums.dart';
import 'app_router.dart';

enum Routes {
  splashScreen,
  dashboardScreen,
  signInScreen,
  selectClassAndSemScreen,
  attendanceReportScreen,
  viewAttendanceScreen,
  createAttendanceScreen,
  updateAttendanceScreen,
  reportsScreen,
  signUpScreen,
  qrViewerScreen,
  qrScannerScreen,
  profileScreen,
  myProfileEditScreen,

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