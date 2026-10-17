import 'package:flutter/material.dart';

class CardText extends StatelessWidget {
  
  const CardText({
    required this.text,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
      ),
    );
  }

}