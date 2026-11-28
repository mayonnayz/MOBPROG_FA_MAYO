import 'package:fa6_mayo/models/account.dart';
import 'package:fa6_mayo/screens/movie_list_screen.dart';
import 'package:fa6_mayo/screens/profile_screen.dart';
import 'package:fa6_mayo/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 44, 72, 115);
const Color secondaryColor = Color.fromARGB(255, 158, 170, 192);

const Color darkPrimaryColor = Color.fromARGB(255, 158, 170, 192);
const Color darkSecondaryColor = Color.fromARGB(255, 44, 72, 115);

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 44, 72, 115),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 158, 170, 192),
);

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
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
            builder: (context) => MovieListScreen(
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
      },
      onSettings: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(isDarkMode: isDarkMode, onToggleDarkMode: onToggleDarkMode,),
          ),
        );
      },
      onLogout: () => logout(context),
    );
  }
}
