import 'package:flutter/material.dart';
import 'generated/color_schemes.g.dart';

const appBarColor = Color(0xff7144AB);
final cashHelperLightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      color: appBarColor,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300),
      displaySmall: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      displayMedium: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
    ),
    colorScheme: lightColorScheme);
