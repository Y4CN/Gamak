import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';

class TrickScreen extends StatelessWidget {
  const TrickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: GenerallColor.primaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.forward,
                    size: 26,
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'NAme Game',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'vazirm',
              ),
            ),
          )
        ],
      ),
    );
  }
}
