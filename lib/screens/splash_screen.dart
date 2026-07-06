import 'package:flutter/material.dart';
import 'dart:async';
import 'login_signup_choice.dart'; // this is screen 2

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const LoginSignupChoiceScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/monex_logo.png'),
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text("MONEX", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("Trading for everyone!", style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
          ],
        ),
      ),
    );
  }
}
