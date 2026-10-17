import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.text, required this.onPressed, required this.color});

  final String text;
  final dynamic color;
  final void Function() onPressed;
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      
      child: StyledText(text, 20, color: const Color.fromARGB(255, 78, 64, 0)),
    );
  }
}