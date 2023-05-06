import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authBloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/userModel.dart';
import 'package:game_hacks_chat/utilities/changeUserListen.dart';
import 'package:game_hacks_chat/utilities/fileManager.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:game_hacks_chat/widget/customTextField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  File? _imagefile;
  late ValueNotifier _imageNotof;

  @override
  void initState() {
    super.initState();
    _imageNotof = ValueNotifier<bool>(false);
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
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'vazirm',
            ),
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
            Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: _imageNotof,
                  builder: (context, value, child) {
                    if (value || _imagefile != null) {
                      return Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(_imagefile!),
                              fit: BoxFit.cover,
                            )),
                      );
                    }
                    return CachedNetworkImage(
                      imageUrl: widget.userModel.avatar,
                      errorWidget: (context, url, error) {
                        return Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.person,
                              color: Colors.black,
                              size: 30,
                            ));
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: GenerallColor.appBarBackGroundColor,
                            size: 20,
                          ),
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () async {
                      var fileback = await FileManager.pickFile();
                      fileback.fold((l) {
                        return CustomSnakBar.getCustomSnakBar(l, context);
                      }, (r) {
                        _imagefile = r;
                        _imageNotof.value = true;
                        _imageNotof.notifyListeners();
                        return;
                      });
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black)),
                      child: const Icon(
                        CupertinoIcons.add,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: Text(
                    'برای تغییر ایمیل و اسم کاربری به پشتیبانی پیام دهید '),
              ),
            ),
            const Spacer(),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthEditUserDetailsResponseState) {
                  state.response.fold((l) {
                    CustomSnakBar.getCustomSnakBar(l, context);
                  }, (r) {
                    if (r) {
                      CustomSnakBar.getCustomSnakBar(
                          'اطلاعات شما با موفقیت ویرایش شد', context);
                      ChangeUserListen.changeUser.value = true;
                      ChangeUserListen.changeUser.notifyListeners();
                      Navigator.pop(context);
                    }
                  });
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                      if (_nameController.text.trim().isEmpty) {
                        CustomSnakBar.getCustomSnakBar(
                            'لطفا اسم را وارد کنین', context);
                      }
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthChangeUserDetailsEvent(
                          _nameController.text.trim(),
                        ),
                      );
                    },
                    child: const Text(
                      'ویرایش اطلاعات کاربری',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
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
