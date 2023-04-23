import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';

class AddTrickScreen extends StatefulWidget {
  const AddTrickScreen({super.key});

  @override
  State<AddTrickScreen> createState() => _AddTrickScreenState();
}

class _AddTrickScreenState extends State<AddTrickScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GenerallColor.appBarBackGroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 80,
          title: Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: GenerallColor.primaryColor.withOpacity(.6),
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.back,
                          color: GenerallColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      'ترفندت رو اینجا بنویس !',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'vazirm',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  minLines: 10,
                  maxLines: 15,
                  decoration: InputDecoration(
                    hintText: 'ترفند خودتون رو ثبت کنین',
                    hintStyle: TextStyle(fontFamily: 'vazirm'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 130,
                width: double.infinity,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
