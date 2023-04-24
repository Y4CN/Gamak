import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';

class ClientTrickScreen extends StatefulWidget {
  const ClientTrickScreen({super.key});

  @override
  State<ClientTrickScreen> createState() => _ClientTrickScreenState();
}

class _ClientTrickScreenState extends State<ClientTrickScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SliverAppBar(
                    backgroundColor: GenerallColor.appBarBackGroundColor,
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Padding(
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
                                color:
                                    GenerallColor.primaryColor.withOpacity(.6),
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
                              'ترفند های شما',
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
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: TabBarViewDelegate(
                    const TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.black,
                      indicatorPadding: EdgeInsets.only(bottom: 4),
                      // indicatorWeight: 2,
                      indicatorColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'vazirm',
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            'در حال بررسی',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'رد شده',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'قبول شده',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                _UnChechedTrick(),
                _BadTrick(),
               _GoodTrick()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabBarViewDelegate extends SliverPersistentHeaderDelegate {
  TabBarViewDelegate(this._tabBar);

  final TabBar _tabBar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: GenerallColor.appBarBackGroundColor,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}





class _UnChechedTrick extends StatelessWidget {
  const _UnChechedTrick({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 30,
          margin: const EdgeInsets.all(10),
          color: Colors.red,
        );
      },
    );
  }
}

class _BadTrick extends StatelessWidget {
  const _BadTrick({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 30,
          margin: const EdgeInsets.all(10),
          color: Colors.green,
        );
      },
    );
  }
}

class _GoodTrick extends StatelessWidget {
  const _GoodTrick({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 30,
          margin: const EdgeInsets.all(10),
          color: Colors.black,
        );
      },
    );
  }
}
