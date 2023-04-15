import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/widget/singleItem.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 100,
              centerTitle: true,
              backgroundColor: GenerallColor.primaryColor,
              title: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  print(value);
                  print('***** HERE *****');
                },
                decoration: InputDecoration(
                  // suffixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     CupertinoIcons.mic_fill,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // prefixIcon: const Icon(
                  //   CupertinoIcons.search,
                  //   color: Colors.black,
                  // ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    ),
                  ),
                  hintText: '🎮 جست و جوی بازی مورد نظر 🎮',
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return  Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: Container(color: Colors.red,),
              );
            }, childCount: 10)),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 140),
            ),
          ],
        ),
      ),
    );
  }
}
