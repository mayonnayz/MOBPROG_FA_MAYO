import 'package:fa4_reverse_engineering/model/account.dart';
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
                IconButton(
                  onPressed: onToggleDarkMode,
                  icon: ImageIcon(
                    const AssetImage('assets/dark_mode.png'),
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onSettings,
                  icon: const Icon(Icons.settings),
                  color: Theme.of(context).primaryColor,
                ),
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
                        'Hello\n${account.firstName} ${account.lastName}\nYou are now one of the Fireflies',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ImageIcon(
                        const AssetImage('assets/firefly_logo.png'),
                        color: Theme.of(context).primaryColor,
                        size: 300,
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: 170,
                        child: ElevatedButton(
                          onPressed: onSupplies,
                          child: const Text('Check for Supplies'),
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
