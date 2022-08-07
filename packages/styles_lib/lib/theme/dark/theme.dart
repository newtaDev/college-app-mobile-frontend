part of app_themes;

final darkTheme = FlexThemeData.dark(
  colorScheme: _darkColorScheme,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 6,
  appBarStyle: FlexAppBarStyle.background,
  subThemesData: const FlexSubThemesData(
    useFlutterDefaults: true,
    blendOnLevel: 30,
    blendTextTheme: false,
    useTextTheme: false,
    textButtonRadius: 8,
    elevatedButtonRadius: 8,
    outlinedButtonRadius: 8,
    toggleButtonsRadius: 8,
    inputDecoratorRadius: 12,
    inputDecoratorUnfocusedHasBorder: false,
    fabRadius: 12,
    chipSchemeColor: SchemeColor.primary,
    cardRadius: 8,
    popupMenuRadius: 6,
    dialogBackgroundSchemeColor: SchemeColor.onSecondary,
    inputDecoratorSchemeColor: SchemeColor.onInverseSurface,
    dialogRadius: 18,
    timePickerDialogRadius: 18,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
);
