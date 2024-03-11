import 'package:flutter/material.dart';
import 'package:tracksync/config/constants.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    splashColor: Colors.transparent,
    fontFamily: 'EuclidFlex',
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: mainColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: mainColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      hintStyle: const TextStyle(
        color: mainColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: mainColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: greyColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      bodySmall:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(20),
        ),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        backgroundColor: const MaterialStatePropertyAll(secondColor),
      ),
    ),
  );
}

class NoSplashScrollBehavior extends ScrollBehavior{
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}