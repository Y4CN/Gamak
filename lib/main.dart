import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/mainScreen.dart';
import 'package:game_hacks_chat/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fa'), // fa
      ],
      locale: const Locale('fa'),
      theme: ThemeData(
        fontFamily: 'vazir',
        scaffoldBackgroundColor: GenerallColor.primaryColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
