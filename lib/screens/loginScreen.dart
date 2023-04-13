import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/mainScreen.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailOruserNameController;
  late TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _emailOruserNameController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 200,
              backgroundColor: GenerallColor.appBarBackGroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              centerTitle: true,
              title: Text(
                'ورود',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                  controller: _emailOruserNameController,
                  txt: 'نام کاربری / ایمیل'),
            ),
            SliverToBoxAdapter(
              child:
                  CustomTextFeild(controller: _passController, txt: 'رمز عبور'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        GenerallColor.appBarBackGroundColor.withOpacity(.8),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text(
                    'ورود',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
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
