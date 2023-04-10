import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              centerTitle: true,
              title: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  print(value);
                  print('***** HERE *****');
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.mic_fill,
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                  ),
                  hintText: '🎮 Search Game 🎮',
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Text('data'),
            )
          ],
        ),
      ),
    );
  }
}
