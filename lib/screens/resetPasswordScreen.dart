import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/userModel.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';

class ResetPassScreen extends StatefulWidget {
  ResetPassScreen({super.key, required this.userModel});
  UserModel userModel;
  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  late TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.forward,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
        title: const Text(
          'تغییر رمز عبور',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: GenerallColor.appBarBackGroundColor,
      ),
      body: Column(
        children: [
          CustomTextFeild(
            controller: _emailController,
            txt: 'ایمیل شما',
            isPassword: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                if (_emailController.text.trim().isEmpty ||
                    EmailValidator.validate(_emailController.text.trim())) {
                  CustomSnakBar.getCustomSnakBar(
                      'لطفا ایمیل را درست وارد کنین', context);
                  return;
                }
                if (_emailController.text.trim() != widget.userModel.email) {
                  CustomSnakBar.getCustomSnakBar(
                      'ایمیل شما با ایمیل اکانت مطابقت ندارد', context);
                  return;
                }
              },
              child: const Text(
                'تغییر رمز عبور',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
