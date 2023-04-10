import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: GenerallColor.appBarBackGroundColor,
                toolbarHeight: 200,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 120, right: 10),
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
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GenerallColor.primaryColor.withOpacity(.6),
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.ellipsis_vertical,
                            color: GenerallColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/test2.jpg',
                        fit: BoxFit.cover,
                      ),
                      const Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                GenerallColor.primaryColor,
                              ],
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              stops: [.9, 1],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        minRadius: 35,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name Game',
                              style:
                                  TextStyle(fontSize: 16, fontFamily: 'robotom'
                                      // fontWeight: FontWeight.w600,
                                      ),
                            ),
                            const SizedBox(height: 5),
                            Icon(
                              CupertinoIcons.star,
                              size: 20,
                              color: Colors.yellow.shade600,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: index == 0 ? 12 : 7),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Colors.grey.shade300,
                          ),
                          child: const Text(
                            'category',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: ExpandableText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    expandText: 'Show more',
                    collapseText: 'Show less',
                    maxLines: 3,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.chat_bubble,
                            color: Colors.black,
                            size: 20,
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '10K',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.amber,
                        ),
                      );
                    },
                    childCount: 10,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: .9,
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(
                  bottom: 120,
                ),
              )
            ],
          ),
          Positioned(
            bottom: 50,
            right: 20,
            left: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.white,
                elevation: 20,
                backgroundColor: Colors.green.shade300,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 2,
                    strokeAlign: .1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Buy Game',
                style: TextStyle(fontSize: 20, fontFamily: 'robotom'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
