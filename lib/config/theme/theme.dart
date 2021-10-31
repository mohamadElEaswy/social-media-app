import 'package:flutter/material.dart';
import 'package:untitled/config/theme/constant_colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey[400],
  ),
);