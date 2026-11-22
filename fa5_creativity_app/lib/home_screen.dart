
import 'package:fa5_creativity_app/constants/app_constants.dart';
import 'package:fa5_creativity_app/screen/all_biomes_screen.dart';
import 'package:fa5_creativity_app/screen/questions_screen.dart';
import 'package:flutter/material.dart';
import '../commons/styled_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 450,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 20),

                  const StyledText(
                    'Where will your next adventure lead you? Take the quiz and find out!',
                    AppConstants.mediumFont,
                    align: TextAlign.center,
                  ),

                  const SizedBox(height: 100),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuestionsScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/start.png',
                      width: 400,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllBiomesScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/view_all.jpg',
                      width: 400,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
