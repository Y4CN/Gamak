import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/categoryGameScreen.dart';
import 'package:game_hacks_chat/screens/gameScreen.dart';
import 'package:game_hacks_chat/widget/singleItem.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _bannerPageController;

  @override
  void initState() {
    super.initState();
    _bannerPageController = PageController(viewportFraction: .8);
  }

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
            pinned: false,
            floating: true,
            toolbarHeight: 100,
            centerTitle: false,
            backgroundColor: GenerallColor.appBarBackGroundColor,
            title: const Text(
              'به برنامه چی چی خوش اومدین',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: GenerallColor.primaryColor,
                ),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'اسم کاربر',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 170,
              width: double.infinity,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: 10,
                    controller: _bannerPageController,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _bannerPageController,
                        count: 10,
                        effect: const ScrollingDotsEffect(
                          fixedCenter: true,
                          activeDotColor: Colors.black,
                          dotColor: Colors.white,
                          dotHeight: 12,
                          dotWidth: 12,
                          spacing: 10,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20),
            sliver: SliverToBoxAdapter(
              child: categoryItem(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 10),
                  child: Text(
                    'محبوب ها',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'vazirm',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: index == 0 ? 25 : 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 330,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(right: 20, bottom: 10),
              child: Text(
                'جدید ترین بازی ها',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'vazirm',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: index == 0 ? 10 : 15, left: 20, right: 20),
                  child: const Directionality(
                      textDirection: TextDirection.ltr,
                      child: singleItemGame()),
                );
              },
              childCount: 10,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 160),
          ),
        ],
      )),
    );
  }
}

class categoryItem extends StatelessWidget {
  const categoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: const CategoryGameScreen(), type: PageTransitionType.fade),
        );
      },
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    width: 70,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    'Title',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
