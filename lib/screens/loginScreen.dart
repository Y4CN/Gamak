import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authBloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/mainScreen.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
              automaticallyImplyLeading: false,
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
                txt: 'نام کاربری / ایمیل',
                isPassword: false,
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFeild(
                controller: _passController,
                txt: 'رمز عبور',
                isPassword: false,
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
                    if (state is AuthLoginResponseState) {
                      CustomSnakBar.getCustomSnakBar(
                        'شما با موفقیت وارد شدید',
                        context,
                      );
                      state.login.fold((l) {
                        CustomSnakBar.getCustomSnakBar(l, context);
                      }, (r) {
                        if (r) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState ||
                        state is AuthLoginResponseState) {
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
                        if (_emailOruserNameController.text.trim().length < 8) {
                          CustomSnakBar.getCustomSnakBar(
                              'لطفا نام کاربری یا ایمیل خود را وارد کنین',
                              context);
                          return;
                        }
                        if (_passController.text.trim().length < 8) {
                          CustomSnakBar.getCustomSnakBar(
                            'لطفا پسورد خود را درست وارد کنین',
                            context,
                          );
                          return;
                        }
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthLoginEvent(
                            _emailOruserNameController.text.trim(),
                            _passController.text.trim(),
                          ),
                        );
                      },
                      child: const Text(
                        'ورود',
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
}
