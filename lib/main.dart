import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/constant/tapselKey.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:pushpole/pushpole.dart';
import 'package:game_hacks_chat/screens/splashScreen.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PushPole.initialize();
  await TapsellPlus.instance.initialize(TapSellKey.key);
  TapsellPlus.instance.setGDPRConsent(true);
  await initGet_it();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'گیمک',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fa'), // Fa
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
