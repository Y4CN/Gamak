import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/userModel.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';

class ChangeUserDetailsScreen extends StatefulWidget {
  ChangeUserDetailsScreen({super.key, required this.userModel});
  UserModel userModel;

  @override
  State<ChangeUserDetailsScreen> createState() =>
      _ChangeUserDetailsScreenState();
}

class _ChangeUserDetailsScreenState extends State<ChangeUserDetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userModel.name);
    _userNameController =
        TextEditingController(text: widget.userModel.username);
    _emailController = TextEditingController(text: widget.userModel.email);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GenerallColor.primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'ویرایش اطلاعات کاربری',
            style: TextStyle(fontSize: 16, fontFamily: 'vazirm'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.forward),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                right: 12,
                left: 12,
              ),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'اسم',
                  labelStyle: const TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                right: 12,
                left: 12,
              ),
              child: TextField(
                enabled: false,
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'نام کاربری',
                  labelStyle: const TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                right: 12,
                left: 12,
              ),
              child: TextField(
                enabled: false,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'ایمیل',
                  labelStyle: const TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const Spacer(),
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
                onPressed: () {},
                child: const Text(
                  'ویرایش اطلاعات کاربری',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
