import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/supportBloc/supportBloc.dart';
import 'package:game_hacks_chat/bloc/supportBloc/supportEvent.dart';
import 'package:game_hacks_chat/bloc/supportBloc/supportState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pushpole/pushpole.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late TextEditingController _titleController;
  late TextEditingController _desController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _desController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GenerallColor.appBarBackGroundColor,
        title: const Text(
          'پشتیبانی',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: 'vazirm'),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
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
      ),
      body: BlocConsumer<SupportBloc, SupportState>(
        listener: (context, state) async {
          if (state is SupportResponseState) {
            CustomSnakBar.getCustomSnakBar(
                'شما با ایمیل این پیام رو برای ادمین ارسال کنین',
                context);
                _desController.clear();
                _titleController.clear();
            // var idNotif = await PushPole.getId();
            // PushPole.sendSimpleNotifToUser(idNotif, 'ممنون از پیام شما',
            //     'پس از بررسی جواب پیام شما به ایمیل شما ارسال می شود');
          }
          if (state is SupportErrorState) {
            // ignore: use_build_context_synchronously
            CustomSnakBar.getCustomSnakBar(
                'متاسفانه ارسال پیام شما با شکست روبه رو شد !', context);
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: TextField(
                      controller: _titleController,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'پشتیبانی برای چی ؟',
                        labelStyle: const TextStyle(
                          fontFamily: 'vazirm',
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: TextField(
                      controller: _desController,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        labelText: 'توضیحات',
                        labelStyle: const TextStyle(
                          fontFamily: 'vazirm',
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GenerallColor.appBarBackGroundColor,
                        minimumSize: const Size(300, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_titleController.text.trim().isEmpty) {
                          CustomSnakBar.getCustomSnakBar(
                              'لطفا بنویسید برای چه چیزی پشتیبانی میخواین؟',
                              context);
                          return;
                        }
                        if (_desController.text.trim().isEmpty) {
                          CustomSnakBar.getCustomSnakBar(
                              'لطفا توضیحات پشتیبانی خود را بنویسید !',
                              context);
                          return;
                        }
                        BlocProvider.of<SupportBloc>(context).add(
                          SupportSendEmailEvent(
                            _desController.text.trim(),
                            _titleController.text.trim(),
                          ),
                        );
                      },
                      child: const Text(
                        'ثبت',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'vazirm',
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
              if (state is SupportLoadingState) ...{
                LoadingAnimationWidget.fourRotatingDots(
                  color: GenerallColor.appBarBackGroundColor,
                  size: 30,
                ),
              },
            ],
          );
        },
      ),
    );
  }
}
