import 'package:flutter/material.dart';


void navigate({required BuildContext context, required String namedRoute, arguments}) {
  Navigator.pushNamed(context, namedRoute,arguments: arguments);
}

void navigateAndRemove(
    {required BuildContext context, required String namedRoute}) {
  Navigator.pushNamedAndRemoveUntil(
      context, namedRoute, (Route<dynamic> route) => false);
}
