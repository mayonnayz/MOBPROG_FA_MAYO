
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(
    this.text,
    this.size, {
    super.key,
    this.color = Colors.white,
    this.align,
  });

  final String text;
  final double size;
  final Color color;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: GoogleFonts.pressStart2p(
        fontSize: size,
        color: color,
        height: 1.7,
      ),
    );
  }
}
