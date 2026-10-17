import 'package:fa2_simple_quiz_app/commons/styled_button.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:fa2_simple_quiz_app/data/questions_data.dart';
import 'package:fa2_simple_quiz_app/model/questions.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onFinish,
  });

  final void Function(int correct) onFinish;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var questionsIndex = 0;
  int correct = 0;
  List<String> shuffledAnswers = [];

  @override
  void initState() {
    super.initState();

    shuffledAnswers = questionsData[questionsIndex].getShuffledList().$1;
  }

  void choiceClick(String selectedAnswer, String correctAnswer) {
    if (selectedAnswer == correctAnswer) {
      correct++;
    }

    if (questionsIndex < questionsData.length - 1) {
      setState(() {
        questionsIndex++;
        shuffledAnswers = questionsData[questionsIndex].getShuffledList().$1;
      });
    } else {
      widget.onFinish(correct);
    }
  }

  @override
  Widget build(BuildContext context) {
    Questions currentQuestion = questionsData[questionsIndex];

    final correctAnswer = currentQuestion.choices[0];
    
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 15,
          children: [
            StyledText(
              currentQuestion.text,
              30,
              color: Colors.white,
            ),
            ...shuffledAnswers.map(
              (answer) => StyledButton(
                color: Color.fromARGB(255, 230, 203, 50),
                text: answer,
                onPressed: () => choiceClick(
                  answer,
                  correctAnswer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
