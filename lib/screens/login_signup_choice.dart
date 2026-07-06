import 'package:flutter/material.dart';
import 'login_details_screen.dart';
import 'signup_screen.dart'; // <-- added signup screen

class LoginSignupChoiceScreen extends StatelessWidget {
  const LoginSignupChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEDC), // warm beige
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/monex_logo.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),

            // App Name
            const Text(
              "MONEX",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Tagline
            const Text(
              "Trading for everyone!",
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            const SizedBox(height: 60),

            // Login section
            const Text("Have you been here before?", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginDetailsScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.black87;
                  }
                  return Colors.black;
                }),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              child: const Text("Log In"),
            ),
            const SizedBox(height: 30),

            // Sign Up section
            const Text("First time at Monex?", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                );
              },
              style: ButtonStyle(
                side: MaterialStateProperty.resolveWith<BorderSide>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const BorderSide(color: Colors.grey, width: 2);
                  }
                  return const BorderSide(color: Colors.black);
                }),
                foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.grey[800]!;
                  }
                  return Colors.black;
                }),
                minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
