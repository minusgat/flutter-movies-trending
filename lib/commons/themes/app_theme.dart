import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class AppTheme {
  const AppTheme._();

  static final bottomNavigationBarThemeData = BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    selectedItemColor: Colors.white,
    selectedLabelStyle: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 14.0,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 12.0,
    ),
    showUnselectedLabels: false,
  );

  //TODO light theme must be implemented in other iteration with some Cubit

  static final darkTheme = ThemeData(
    backgroundColor: darkPrimary,
    primaryColor: darkPrimary,
    accentColor: accent,
    scaffoldBackgroundColor: darkPrimary,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: lightPrimary),
      bodyText2: TextStyle(color: lightPrimary),
      headline1: TextStyle(color: lightPrimary),
      headline2: TextStyle(color: lightPrimary),
      headline3: TextStyle(color: lightPrimary),
      headline4: TextStyle(color: lightPrimary),
      headline5: TextStyle(color: lightPrimary),
      headline6: TextStyle(color: lightPrimary),
      caption: TextStyle(color: lightPrimary),
      subtitle1: TextStyle(color: lightPrimary),
      subtitle2: TextStyle(color: lightPrimary),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    iconTheme: IconThemeData(
      color: lightPrimary,
    ),
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
  );
}
