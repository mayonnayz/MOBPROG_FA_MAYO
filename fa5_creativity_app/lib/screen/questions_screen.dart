
import 'package:fa5_creativity_app/commons/styled_text.dart';
import 'package:fa5_creativity_app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'biome_list_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionsIndex = 0;

  final Map<String, String> userAnswers = {
    'dimension': '',
    'category': '',
    'precipitation': '',
    'rarity': '',
  };

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which dimension would you like to explore?',
      'field': 'dimension',
      'choices': ['overworld', 'nether', 'end'],
    },
    {
      'question': 'What kind of environment do you prefer?',
      'field': 'category',
      'choices': [
        'temperate',
        'cold',
        'warm',
        'ocean',
        'underground',
        'beach_special',
        'nether',
        'end',
      ],
    },
    {
      'question': 'What weather would you prefer?',
      'field': 'precipitation',
      'choices': ['rain', 'snow', 'none'],
    },
    {
      'question': 'How rare should your biome be?',
      'field': 'rarity',
      'choices': ['common', 'uncommon', 'rare', 'very_rare'],
    },
  ];

  void choiceClick(String answer) {
    final currentQuestion = questions[questionsIndex];
    final field = currentQuestion['field'];

    userAnswers[field] = answer;

    if (questionsIndex < questions.length - 1) {
      setState(() {
        questionsIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BiomeListScreen(
            filters: Map<String, String>.from(userAnswers),
          ),
        ),
      );
    }
  }

  String formatText(String text) {
    return text
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[questionsIndex];

    final List<String> choices =
        List<String>.from(currentQuestion['choices']);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dirt_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledText(
                  'QUESTION ${questionsIndex + 1} OF ${questions.length}',
                  AppConstants.mediumFont
                ),

                const SizedBox(height: 35),

                StyledText(
                  currentQuestion['question'],
                  AppConstants.largeFont,
                  align: TextAlign.center,
                ),

                const SizedBox(height: 35),

                ...choices.map(
                  (answer) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => choiceClick(answer),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF795438),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: StyledText(
                          formatText(answer),
                          AppConstants.mediumFont,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
