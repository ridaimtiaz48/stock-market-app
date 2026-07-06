import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MonexApp());
}

class MonexApp extends StatelessWidget {
  const MonexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5EEDC), // Light beige
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
