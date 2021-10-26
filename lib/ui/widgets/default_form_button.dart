import 'package:flutter/material.dart';

class DefaultFormButton extends StatelessWidget {
  const DefaultFormButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(onPressed: () =>onPressed(), child: Text(text),
        style: elevatedButtonStyle,
        ));
  }
}

final ButtonStyle elevatedButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0.0),
);