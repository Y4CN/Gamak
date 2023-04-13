import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/loginScreen.dart';
import 'package:game_hacks_chat/utilities/fileManager.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';
import 'package:permission_handler/permission_handler.dart';

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
  File? userAvatar;
  ValueNotifier _notifier = ValueNotifier<bool>(false);

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
                      ValueListenableBuilder(
                        valueListenable: _notifier,
                        builder: (context, value, child) {
                          return Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: userAvatar == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(userAvatar as File),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            alignment: Alignment.center,
                            child: userAvatar == null
                                ? const Icon(
                                    CupertinoIcons.person,
                                    size: 30,
                                  )
                                : null,
                          );
                        },
                      ),
                      Positioned(
                        top: 1,
                        left: 1,
                        child: GestureDetector(
                          onTap: () async {
                            if (await Permission.storage.isDenied) {
                              Permission.storage.request();
                            }
                            if (await Permission.storage.isGranted) {
                              var eiFile = await FileManager.pickFile();
                              eiFile.fold((l) {
                                CustomSnakBar.getCustomSnakBar(l, context);
                              }, (r) async {
                                userAvatar = r;
                                _notifier.value = await r.exists();
                                _notifier.notifyListeners();
                              });
                            } else {
                              CustomSnakBar.getCustomSnakBar(
                                  'لطفا اجازه دسترسی برای فضای ذخیره سازی را بدهید',
                                  context);
                            }
                          },
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
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                controller: _emailController,
                txt: 'ایمیل',
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                controller: _usernameController,
                txt: ' اسم کاربری',
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                controller: _nameController,
                txt: 'اسم',
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                controller: _passController,
                txt: 'رمز عبور',
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                controller: _confirmPassController,
                txt: 'تایید رمز عبور',
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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

  @override
  void dispose() {
    super.dispose();
    _notifier.dispose();
  }
}
