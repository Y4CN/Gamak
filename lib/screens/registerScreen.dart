import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/loginScreen.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _passController;
  late TextEditingController _confirmPassController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _passController = TextEditingController();
    _confirmPassController = TextEditingController();
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
            SliverAppBar(
              toolbarHeight: 200,
              backgroundColor: GenerallColor.appBarBackGroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              centerTitle: true,
              title: Column(
                children: [
                  const Text(
                    'ثبت نام',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: GenerallColor.primaryColor,
                        child: Icon(
                          CupertinoIcons.person,
                          size: 20,
                        ),
                      ),
                      Positioned(
                        top: 1,
                        left: 1,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            CupertinoIcons.add,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child:
                  CustomTextFeild(controller: _emailController, txt: 'ایمیل'),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                  controller: _usernameController, txt: ' اسم کاربری'),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(controller: _nameController, txt: 'اسم'),
            ),
            SliverToBoxAdapter(
              child:
                  CustomTextFeild(controller: _passController, txt: 'رمز عبور'),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                  controller: _confirmPassController, txt: 'تایید رمز عبور'),
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ), (route) => false);
                  },
                  child: const Text(
                    'ثبت نام',
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
