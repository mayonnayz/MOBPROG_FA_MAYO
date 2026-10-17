import 'package:flutter/material.dart';
import 'package:fa1_personal_profile_card/text_design.dart';

class CardDesign extends StatelessWidget {
  const CardDesign({
    required this.name,
    required this.program,
    required this.motto,
  });

  final String name;
  final String program;
  final String motto;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        height: 300,
        width: 480,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 230, 221, 143),
              Color.fromARGB(255, 235, 151, 112),
              Color.fromARGB(255, 218, 118, 111),
              Color.fromARGB(255, 235, 151, 112),
              Color.fromARGB(255, 219, 218, 123),
            ],
            radius: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            CardText(
              text: name,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 56, 1, 1),
            ),
            CardText(
              text: program,
              fontSize: 20,
              color: Color.fromARGB(255, 85, 3, 3),
            ),
            CardText(
              text: motto,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 70, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
