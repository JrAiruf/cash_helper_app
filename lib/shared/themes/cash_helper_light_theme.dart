import 'package:flutter/material.dart';
import 'generated/color_schemes.g.dart';

const appBarColor = Color(0xff7144AB);
final cashHelperLightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white, size: 30),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
    ),
    useMaterial3: true,
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
    colorScheme: lightColorScheme);
