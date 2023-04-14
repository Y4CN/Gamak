import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authBloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/loginScreen.dart';
import 'package:game_hacks_chat/utilities/fileManager.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthRegisterResponseState) {
                      CustomSnakBar.getCustomSnakBar(
                        'شما با موفقیت ثبت نام کردین',
                        context,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: GenerallColor.appBarBackGroundColor,
                          size: 30,
                        ),
                      );
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:
                            GenerallColor.appBarBackGroundColor.withOpacity(.8),
                      ),
                      onPressed: () {
                        if (!EmailValidator.validate(
                            _emailController.text.trim())) {
                          CustomSnakBar.getCustomSnakBar(
                              'لطفا ایمیل رو درست وارد کنین !', context);
                          return;
                        }
                        if (_usernameController.text.trim().length < 8) {
                          CustomSnakBar.getCustomSnakBar(
                              'اسم کاربری باید بیشتر از ۸ کاراکتر باشد',
                              context);
                          return;
                        }
                        if (_nameController.text.trim().isEmpty) {
                          CustomSnakBar.getCustomSnakBar(
                              'لطفا اسم را وارد کنین',
                              context);
                          return;
                        }
                        if (_passController.text.trim().length < 8) {
                          CustomSnakBar.getCustomSnakBar(
                              'رمز عبور باید بیشتر از ۸ کاراکتر باشد', context);
                          return;
                        }
                        if (_passController.text.trim() !=
                            _confirmPassController.text.trim()) {
                          CustomSnakBar.getCustomSnakBar(
                              'رمز شما با تایید رمز یکی نیست', context);
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthRegisterEvent(
                            userAvatar,
                            _emailController.text.trim(),
                            _nameController.text.trim(),
                            _passController.text.trim(),
                            _confirmPassController.text.trim(),
                            _usernameController.text.trim(),
                          ),
                        );

                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return const LoginScreen();
                        //   },
                        // ), (route) => false);
                      },
                      child: const Text(
                        'ثبت نام',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
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
