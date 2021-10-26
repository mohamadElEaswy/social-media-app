import 'package:flutter/material.dart';
import 'package:untitled/config/theme/constatnt_colors.dart';

class DefaultTextFormField extends StatelessWidget {

  const DefaultTextFormField({
    Key? key,
    required this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixOnPressed,
    required this.keyboardType,
    required this.controller,
    required this.onFieldSubmitted,
    required this.validator,
    required this.hintText,
  }) : super(key: key);
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function onFieldSubmitted;
  final Function validator;
  final Function? suffixOnPressed;
  final String? hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool obscureText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      onFieldSubmitted: (String? value) => onFieldSubmitted(value),
      validator: (String? value) => validator(value),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: defaultColor,
        suffixIcon:
            IconButton(onPressed: () => suffixOnPressed!(), icon: Icon(suffixIcon)),
        prefixIcon: Icon(prefixIcon),
        // enabledBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(color: defaultColor)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
