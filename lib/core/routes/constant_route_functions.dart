import 'package:flutter/material.dart';

void navigate({required BuildContext context, required String namedRoute}){
  Navigator.pushNamed(context, namedRoute);
}
void navigateAndRemove({required BuildContext context, required String namedRoute}){
  Navigator.pushNamedAndRemoveUntil(
      context, namedRoute,
          // (Route route) => false
          // (Route<dynamic> route) => false
          (route) => false
  );
}