import 'package:flutter/material.dart';
import 'package:untitled/config/theme/constant_colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,fontFamily: 'Jannah',
  appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),actionsIconTheme: IconThemeData(color: Colors.blue),
      titleTextStyle: TextStyle(color: Colors.blue, fontFamily: 'Jannah')),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey[400],
  ),
);
