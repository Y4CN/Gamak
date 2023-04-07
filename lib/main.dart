import 'package:flutter/material.dart';
import 'package:game_hacks_chat/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(
          0xffF6F7FF
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
