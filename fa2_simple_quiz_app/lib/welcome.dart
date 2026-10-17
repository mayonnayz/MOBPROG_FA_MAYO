import 'package:fa2_simple_quiz_app/question/questions_screen.dart';
import 'package:fa2_simple_quiz_app/results/results_screen.dart';
import 'package:fa2_simple_quiz_app/welcome_screen.dart';
import 'package:flutter/material.dart';

const welcomeScreen = 'welcome-screen';
const questionsScreen = 'questions-screen';
const resultsScreen = 'results-screen';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var activeScreen = welcomeScreen;
  int correct = 0;

  
  
  void switchScreen() {
    setState(() {
      activeScreen = questionsScreen;
      correct = 0;
    });
  }

  void showResults(int score) {
    setState(() {
      correct = score;
      activeScreen = resultsScreen;
    });
  }

  void restartQuiz() {
    setState(() {
      activeScreen = welcomeScreen;
      correct = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = WelcomeScreen(switchScreen);

    if (activeScreen == questionsScreen) {
      currentScreen = QuestionsScreen(
        onFinish: showResults,
      );
    }

    if (activeScreen == resultsScreen) {
      currentScreen = ResultsScreen(
        correct: correct,
        onExit: restartQuiz,
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 91, 73, 97),
        body: Center(
          child: currentScreen,
        ),
      ),
    );
  }
}