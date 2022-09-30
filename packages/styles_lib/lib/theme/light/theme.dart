part of app_themes;

final lightTheme = FlexThemeData.light(
  // scheme: FlexScheme.shark,
  colorScheme: lightColorScheme,
  appBarStyle: FlexAppBarStyle.background,
  appBarElevation: 0.3,
  fontFamily: FontAssets.poppins,
  subThemesData: const FlexSubThemesData(
    // useFlutterDefaults: true,
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
).copyWith(
  primaryColorLight: Colors.grey[200],
  inputDecorationTheme: _textInputDecorationTheme(isDarkMode: false),
  bottomNavigationBarTheme: _bottomNavBartheme(),
  elevatedButtonTheme: _elevatedButtonTheme(),
  pageTransitionsTheme: _cupertionPageTransition(),
  appBarTheme: FlexThemeData.light(
    appBarStyle: FlexAppBarStyle.background,
    appBarElevation: 0.3,
  ).appBarTheme.copyWith(centerTitle: true),
);
