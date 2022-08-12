part of app_themes;

BottomNavigationBarThemeData _bottomNavBartheme() =>
    const BottomNavigationBarThemeData(elevation: 8);

InputDecorationTheme _textInputDecorationTheme() {
  final _withoutBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  );
  final _errorBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: _darkColorScheme.error),
  );
  return InputDecorationTheme(
    focusedBorder: _withoutBorder,
    enabledBorder: _withoutBorder,
    border: _withoutBorder,
    errorBorder: _errorBorder,
    disabledBorder: _withoutBorder,
    focusedErrorBorder: _errorBorder.copyWith(
      borderSide: BorderSide(color: _lightColorScheme.error, width: 2),
    ),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  );
}
