import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authBloc.dart';
import 'package:game_hacks_chat/data/datasource/authDataSourca.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/screens/mainScreen.dart';
import 'package:game_hacks_chat/screens/registerScreen.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (ShareManager.isLogedin()) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AuthBloc(),
              child: const RegisterScreen(),
            ),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/logo_transparent.png',
              width: 350,
            ),
            const Spacer(),
            const Text(
              'گیمک',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'vazirm',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 120,
                width: 120,
                child: RiveAnimation.asset('assets/rive/loading.riv')),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
