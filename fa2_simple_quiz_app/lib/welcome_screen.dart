import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen(this.switchScreen, {super.key});

  final void Function() switchScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/start.jpg', width: 300, height: 300),

        StyledText('Filipino Pop Culture Quiz!', 30, color: const Color.fromARGB(255, 240, 238, 111)),

        OutlinedButton.icon(
          onPressed: switchScreen,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
            backgroundColor: const Color.fromARGB(255, 65, 17, 58),
            foregroundColor: Colors.white,
          ),
          label: StyledText('Start Quiz', 15, color: Colors.white),
        ),
      ],
    );
  }
}
