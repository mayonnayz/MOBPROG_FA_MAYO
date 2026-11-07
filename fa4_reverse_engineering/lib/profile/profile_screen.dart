import 'package:fa4_reverse_engineering/data/accounts.dart';
import 'package:fa4_reverse_engineering/model/account.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Function(Account) onLogin;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const ProfileScreen({
    super.key,
    required this.onLogin,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignup = false;
  bool showPassword = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Color(0xFF73342C)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Color(0xFF73342C),
        ),
      ),
    );
  }

  void submit() {
    if (isSignup) {
      if (usernameController.text.trim().isEmpty ||
          passwordController.text.isEmpty ||
          firstNameController.text.trim().isEmpty ||
          lastNameController.text.trim().isEmpty) {
        return;
      }

      if (accounts.any(
        (account) => account.username == usernameController.text.trim(),
      )) {
        return;
      }

      final account = Account(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: usernameController.text.trim(),
        password: passwordController.text,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
      );

      accounts.add(account);

      setState(() {
        isSignup = false;
        usernameController.text = account.username;
        passwordController.clear();
        firstNameController.clear();
        lastNameController.clear();
        showPassword = false;
      });
    } else {
      try {
        final account = accounts.firstWhere(
          (account) =>
              account.username == usernameController.text.trim() &&
              account.password == passwordController.text,
        );

        widget.onLogin(account);
      } catch (e) {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: Text('Login failed.'),
              content: Text('Invalid username or password'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: widget.onToggleDarkMode,
                icon: ImageIcon(
                  const AssetImage('assets/dark_mode.png'),
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      if (isSignup) ...[
                        FittedBox(
                          fit: BoxFit.contain,
                          child: ImageIcon(
                            const AssetImage('assets/firefly_logo.png'),
                            color: Theme.of(context).primaryColor,
                            size: 300,
                          ),
                        ),
                        Text(
                          'Become a Firefly',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: usernameController,
                          maxLength: 50,
                          style: TextStyle(color: Theme.of(context).primaryColor,),
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 9),
                        TextField(
                          controller: passwordController,
                          obscureText: !showPassword,
                          style: TextStyle(color: Theme.of(context).primaryColor,),
                          decoration:
                              const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                        ),
                        const SizedBox(height: 9),
                        TextField(
                          controller: firstNameController,
                          maxLength: 50,
                          style: TextStyle(color: Theme.of(context).primaryColor,),
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 9),
                        TextField(
                          controller: lastNameController,
                          maxLength: 50,
                          style: TextStyle(color: Theme.of(context).primaryColor,),
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: submit,
                            child: const Text('Signup'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isSignup = false;
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                      ] else ...[
                        FittedBox(
                          fit: BoxFit.contain,
                          child: ImageIcon(
                            const AssetImage('assets/firefly_logo.png'),
                            color: Theme.of(context).primaryColor,
                            size: 1000,
                          ),
                        ),
                        TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Theme.of(context).primaryColor,),
                        ),
                        const SizedBox(height: 9),
                        TextField(
                          controller: passwordController,
                          obscureText: !showPassword,
                          style: TextStyle(color: Theme.of(context).primaryColor,),
                          decoration:
                              const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: submit,
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isSignup = true;
                                usernameController.clear();
                                passwordController.clear();
                              });
                            },
                            child: const Text(
                              'Does not have an account yet? Sign Up now!',
                            ),
                          ),
                        ),
                      ],
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
