import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60, left: 25),
                    child: IconButton(
                      tooltip: 'ویرایش اطلاعات کاربر',
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.pencil_circle,
                      ),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                  )
                ],
                toolbarHeight: 150,
                backgroundColor: GenerallColor.appBarBackGroundColor,
                centerTitle: true,
                title: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.person,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    Positioned(
                        top: 7,
                        left: 7,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.add,
                            color: Colors.black,
                          ),
                        ))
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: MyDelegate(
                  Container(
                    color: GenerallColor.appBarBackGroundColor,
                    alignment: Alignment.center,
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'اسم کاربر',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'اسم یوزر ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListTile(
                      leading: const Icon(
                        Icons.key,
                        color: Colors.black54,
                      ),
                      onTap: () {},
                      title: const Text('تغییر رمز عبور'),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: .2,
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.game_controller_solid,
                        color: Colors.black54,
                      ),
                      onTap: () {},
                      title: const Text('سفارش های بازی شما'),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: .2,
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.bubble_left_fill,
                        color: Colors.black54,
                      ),
                      onTap: () {},
                      title: const Text(
                        'پشتیبانی',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: .2,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.remove_circle,
                        color: Colors.black54,
                      ),
                      onTap: () {},
                      title: const Text('خروج از اکانت'),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: .2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this._cont);

  final Container _cont;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _cont;
  }

  @override
  double get maxExtent => 75;

  @override
  double get minExtent => 75;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
