import 'package:flutter/material.dart';
import 'package:fa1_personal_profile_card/card_design.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 58, 27, 2),
        body: Center(
          child: CardDesign(
            name: "Zyann Lynn C. Mayo", 
            program: "BS Applied Mathematics\n(Information Technology Track)", 
            motto: "Know yourself so intimately that no one else's projection\nor judgement could ever disturb the reality of who you are."
            ),
        ),
      ),
    ),
  );
}
