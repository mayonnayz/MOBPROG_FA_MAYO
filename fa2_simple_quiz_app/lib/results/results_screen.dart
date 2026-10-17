import 'package:fa2_simple_quiz_app/commons/styled_button.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:fa2_simple_quiz_app/data/result_data.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.correct,
    required this.onExit,
  });

  final int correct;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final result = resultData[correct];
    
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const StyledText(
              'Pop Quiz Results!',
              30,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            Image.asset(
              result.imgPath,
              width: 250,
              height: 250,
            ),

            const SizedBox(height: 20),

            StyledText(
              result.scoreText,
              24,
              color: Colors.white,
            ),

            const SizedBox(height: 30),

            StyledButton(
              color: Color.fromARGB(255, 206, 116, 191),
              text: 'Restart Quiz',
              onPressed: onExit,
            ),
          ],
        ),
      ),
    );
  }
}