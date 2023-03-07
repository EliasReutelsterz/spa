import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightBottomAppBarColor = Color(0xff1A3A3A);
  static const Color _lightAppBarColor = Color(0xff1A3A3A);
  static const Color _lightScaffoldBackgroundCoor = Colors.white;
  static const Color _lightPrimary = Color(0xff1A3A3A);
  static const Color _lightSecondary = Color.fromARGB(255, 243, 186, 156);
  static const Color _lightTertiary = Color.fromARGB(255, 230, 238, 238);
  static const Color _lightOnPrimary = Colors.white;
  static const Color _lightPrimaryTextColor = Colors.white;
  static const Color _lightSecondaryTextColor = Colors.black;
  static const Color _lightIconColor = Colors.white;

  static const TextStyle _lightHeadingText1 = TextStyle(
    color: _lightPrimaryTextColor,
    fontFamily: "Rubik",
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle _lightHeadingText2 = TextStyle(
    color: _lightSecondaryTextColor,
    fontFamily: "Rubik",
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle _lightBodyText = TextStyle(
    color: _lightPrimaryTextColor,
    fontFamily: "Rubik",
    fontSize: 14,
  );

  static const TextTheme _lightTextTheme= TextTheme(
    headline1: _lightHeadingText1,
    headline2: _lightHeadingText2,
    bodyText1: _lightBodyText,
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightScaffoldBackgroundCoor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: _lightPrimaryTextColor,
      ),
      color: _lightAppBarColor,
      iconTheme: IconThemeData(color: _lightIconColor),
    ),
    bottomAppBarColor: _lightBottomAppBarColor,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      tertiary: _lightTertiary,
      onPrimary: _lightOnPrimary,
    ),
    textTheme: _lightTextTheme,
  );


    static const Color _darkBottomAppBarColor = Color.fromARGB(255, 79, 79, 79);
  static const Color _darkAppBarColor = Color.fromARGB(255, 79, 79, 79);
  static const Color _darkScaffoldBackgroundCoor = Color.fromARGB(255, 60, 60, 60);
  static const Color _darkPrimary = Color.fromARGB(255, 243, 186, 156);
  static const Color _darkSecondary = Color.fromARGB(255, 65, 191, 217);
  static const Color _darkTertiary = Color.fromARGB(255, 159, 159, 159);
  static const Color _darkOnPrimary = Color.fromARGB(255, 0, 0, 0);
  static const Color _darkPrimaryTextColor = Color.fromARGB(255, 240, 240, 240);
  static const Color _darkSecondaryTextColor = Color.fromARGB(255, 191, 191, 191);
  static const Color _darkIconColor = Color.fromARGB(255, 243, 186, 156);

    static const TextStyle _darkHeadingText1 = TextStyle(
    color: _darkPrimaryTextColor,
    fontFamily: "Rubik",
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle _darkHeadingText2 = TextStyle(
    color: _darkSecondaryTextColor,
    fontFamily: "Rubik",
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle _darkBodyText = TextStyle(
    color: _darkPrimaryTextColor,
    fontFamily: "Rubik",
    fontSize: 14,
  );

  static const TextTheme _darkTextTheme = TextTheme(
    headline1: _darkHeadingText1,
    headline2: _darkHeadingText2,
    bodyText1: _darkBodyText,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkScaffoldBackgroundCoor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: _darkPrimaryTextColor,
      ),
      color: _darkAppBarColor,
      iconTheme: IconThemeData(color: _darkIconColor),
    ),
    bottomAppBarColor: _darkBottomAppBarColor,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      tertiary: _darkTertiary,
      onPrimary: _darkOnPrimary,
    ),
    textTheme: _darkTextTheme,
  );
}
