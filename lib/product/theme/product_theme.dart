import 'package:flutter/material.dart';

class ProductTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(centerTitle: true),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ThemeData.dark().backgroundColor,
        elevation: ThemeData.dark().appBarTheme.elevation,
      ),
    ),
  );
}
