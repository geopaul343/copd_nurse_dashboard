import 'package:flutter/material.dart';

ThemeData get themeData => ThemeData(
  appBarTheme: const AppBarTheme(),
  inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(12, 58),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  ),
  useMaterial3: true,
  platform: TargetPlatform.iOS,
  colorScheme: const ColorScheme.light(primary: Colors.black),
);

ButtonStyle get shrinkedButton => TextButton.styleFrom(
  minimumSize: const Size(0, 0),
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
