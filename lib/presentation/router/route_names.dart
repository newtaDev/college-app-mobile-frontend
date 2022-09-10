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
