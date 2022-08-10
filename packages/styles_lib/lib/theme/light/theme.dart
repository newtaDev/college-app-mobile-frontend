part of app_themes;

final lightTheme = FlexThemeData.light(
  // scheme: FlexScheme.shark,
  colorScheme: _lightColorScheme,
  appBarStyle: FlexAppBarStyle.background,
  appBarElevation: 12,
  fontFamily: FontAssets.poppins,
  subThemesData: const FlexSubThemesData(
    useFlutterDefaults: true,
    useTextTheme: false,
    blendOnColors: false,
    textButtonRadius: 8,
    elevatedButtonRadius: 8,
    outlinedButtonRadius: 8,
    toggleButtonsRadius: 8,
    inputDecoratorRadius: 11,
    inputDecoratorUnfocusedHasBorder: false,
    fabRadius: 12,
    chipSchemeColor: SchemeColor.primary,
    cardRadius: 8,
    popupMenuRadius: 6,
    dialogBackgroundSchemeColor: SchemeColor.onPrimary,
    dialogRadius: 18,
    timePickerDialogRadius: 18,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
