import 'package:flutter/material.dart';

class SnackBars {
  static buildSnackBar({required BuildContext context, required String text, required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),backgroundColor: backgroundColor,
      ),
    );
  }
}
