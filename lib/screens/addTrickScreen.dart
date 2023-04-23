import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';

class AddTrickScreen extends StatefulWidget {
  const AddTrickScreen({super.key});

  @override
  State<AddTrickScreen> createState() => _AddTrickScreenState();
}

class _AddTrickScreenState extends State<AddTrickScreen> {
  late TextEditingController _titleTextEditController;
  late TextEditingController _descriptionTexrEditController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _titleTextEditController = TextEditingController();
    _descriptionTexrEditController = TextEditingController();
    _pageController = PageController(viewportFraction: .8);
  }

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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: TextField(
                    controller: _titleTextEditController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      labelText: 'اسم ترفند',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: _descriptionTexrEditController,
                    minLines: 10,
                    maxLines: 15,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: .2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GenerallColor.appBarBackGroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'اضافه کردن عکس',
                          style: TextStyle(
                            fontFamily: 'vazirm',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GenerallColor.appBarBackGroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      if (_titleTextEditController.text.trim().isEmpty) {
                        CustomSnakBar.getCustomSnakBar(
                            'لطفا اسم ترفند را وارد کنین', context);
                        return;
                      }
                      if (_descriptionTexrEditController.text.trim().isEmpty &&
                          _descriptionTexrEditController.text.trim().length <=
                              10) {
                        CustomSnakBar.getCustomSnakBar(
                            'لطفا ترفند خودتون رو بنویسین', context);
                        return;
                      }
                    },
                    child: const Text(
                      'ثبت ترفند',
                      style: TextStyle(
                        fontFamily: 'vazirm',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
