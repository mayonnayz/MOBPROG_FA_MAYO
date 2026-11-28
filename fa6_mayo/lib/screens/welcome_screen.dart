import 'package:fa6_mayo/models/account.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final Account account;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final VoidCallback onSupplies;
  final VoidCallback onSettings;
  final VoidCallback onLogout;

  const WelcomeScreen({
    super.key,
    required this.account,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onSupplies,
    required this.onSettings,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: onLogout,
                  icon: const Icon(Icons.logout),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hello\n${account.firstName} ${account.lastName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset('assets/images/meme.jpg'),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: 170,
                        child: ElevatedButton(
                          onPressed: onSupplies,
                          child: const Text('Check for Movies'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
