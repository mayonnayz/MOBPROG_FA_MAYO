import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/home_screen.dart';
import 'package:fa4_reverse_engineering/model/account.dart';
import 'package:fa4_reverse_engineering/parameters/parameters_screen.dart';
import 'package:fa4_reverse_engineering/profile/profile_screen.dart';
import 'package:fa4_reverse_engineering/supply_manager/supply_screen.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF73342C);
const Color secondaryColor = Color(0xFFFFDAD5);

const Color darkPrimaryColor = Color(0xFFFFDAD5);
const Color darkSecondaryColor = Color(0xFF73342C);

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: primaryColor,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: darkPrimaryColor,
);

class FireflyBase extends StatefulWidget {
  const FireflyBase({super.key});

  @override
  State<FireflyBase> createState() => _FireflyBaseState();
}

class _FireflyBaseState extends State<FireflyBase> {
  var _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: secondaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: secondaryColor,
        ),
        cardTheme: CardThemeData(
          color: secondaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: secondaryColor,
          ),
        ),
      ),
      darkTheme: ThemeData().copyWith(
        colorScheme: kDarkColorScheme,
        primaryColor: darkPrimaryColor,
        scaffoldBackgroundColor: darkSecondaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: darkPrimaryColor,
          foregroundColor: darkSecondaryColor,
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF5d3f3b),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkPrimaryColor,
            foregroundColor: darkSecondaryColor,
          ),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LoginPage(
        isDarkMode: _isDarkMode,
        onToggleDarkMode: _toggleDarkMode,
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const LoginPage({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      isDarkMode: isDarkMode,
      onToggleDarkMode: onToggleDarkMode,
      onLogin: (account) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(
              account: account,
              isDarkMode: isDarkMode,
              onToggleDarkMode: onToggleDarkMode,
            ),
          ),
        );
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  final Account account;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const WelcomePage({
    super.key,
    required this.account,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      isDarkMode: isDarkMode,
                      onToggleDarkMode: onToggleDarkMode,
                    ),
                  ),
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(
      account: account,
      isDarkMode: isDarkMode,
      onToggleDarkMode: onToggleDarkMode,
      onSupplies: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SupplyManagerScreen(
              onBack: () => Navigator.pop(context),
              parameters: parameters,
            ),
          ),
        );
      },
      onSettings: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParametersScreen(),
          ),
        );
      },
      onLogout: () => logout(context),
    );
  }
}
