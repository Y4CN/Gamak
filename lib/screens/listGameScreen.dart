import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';

class ListGameScreen extends StatefulWidget {
  ListGameScreen({super.key, required this.title});
  String title;
  @override
  State<ListGameScreen> createState() => _ListGameScreenState();
}

class _ListGameScreenState extends State<ListGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            size: 26,
          ),
        ),
        surfaceTintColor: GenerallColor.primaryColor,
        backgroundColor: GenerallColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     child: Expanded(
      //       child: ListView.builder(
      //         itemCount: r.length,
      //         itemBuilder: (context, index) {
      //           return Padding(
      //             padding: const EdgeInsets.only(bottom: 14),
      //             child: singleItemGame(gameProductModel: r[index]),
      //           );
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
