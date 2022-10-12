part of app_themes;

BottomNavigationBarThemeData _bottomNavBartheme() =>
    const BottomNavigationBarThemeData(elevation: 8);

InputDecorationTheme _textInputDecorationTheme({required bool isDarkMode}) {
  final _withoutBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  );
  final _errorBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: darkColorScheme.error),
  );
  return InputDecorationTheme(
    focusedBorder: _withoutBorder,
    enabledBorder: _withoutBorder,
    border: _withoutBorder,
    errorBorder: _errorBorder,
    disabledBorder: _withoutBorder,
    focusedErrorBorder: _errorBorder.copyWith(
      borderSide: BorderSide(color: lightColorScheme.error, width: 2),
    ),
    filled: true,
    fillColor: isDarkMode ? ColorPallet.darkGrey : ColorPallet.grey80,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
OutlinedButtonThemeData _outlinedButtonTheme() {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

PageTransitionsTheme _cupertionPageTransition() {
  return const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
