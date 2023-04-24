import 'package:flutter/material.dart';
import 'generated/color_schemes.g.dart';

const appBarColor = Color(0xFFE6E1E6);
final cashHelperLightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.black,
        size: 30,
      ),
      color: appBarColor,
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 30,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
      displaySmall: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
    ),
    colorScheme: lightColorScheme);
