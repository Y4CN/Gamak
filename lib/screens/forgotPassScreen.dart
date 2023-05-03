import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authBloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  late TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthForgotPassResponseState) {
            state.response.fold((l) {
              CustomSnakBar.getCustomSnakBar(l, context);
            }, (r) {
              _emailController.clear();
              if (r) {
                CustomSnakBar.getCustomSnakBar(
                    'لطفا ایمیل خود را چک کنین (هرزنامه رو هم چک کنین)',
                    context);
              } else {
                CustomSnakBar.getCustomSnakBar(
                  'درخواست شما به مشکلی خورده است !',
                  context,
                );
              }
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                    'فراموشی رمز عبور',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CustomTextFeild(
                    controller: _emailController,
                    txt: 'ایمیل خودتون رو وارد کنین',
                    isPassword: false,
                  ),
                ),
                if (state is AuthLoadingState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: LoadingAnimationWidget.fourRotatingDots(
                          color: GenerallColor.appBarBackGroundColor, size: 30),
                    ),
                  )
                },
                if (state is AuthForgotPassResponseState ||
                    state is AuthInitState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: GenerallColor.appBarBackGroundColor
                              .withOpacity(.8),
                        ),
                        onPressed: () {
                          if (_emailController.text.trim().isEmpty) {
                            CustomSnakBar.getCustomSnakBar(
                                'لطفا ایمیل رو وارد کنین', context);
                            return;
                          }
                          if (!EmailValidator.validate(
                              _emailController.text.trim())) {
                            CustomSnakBar.getCustomSnakBar(
                                'لطفا ایمیل رو درست وارد کنین', context);
                            return;
                          }
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthForgotPassEvent(_emailController.text.trim()),
                          );
                        },
                        child: const Text(
                          'ثبت',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  )
                }
              ],
            ),
          );
        },
      ),
    );
  }
}
