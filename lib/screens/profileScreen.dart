import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authBloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickBloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickEvent.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/clientTrickScreen.dart';
import 'package:game_hacks_chat/screens/splashScreen.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(AuthReadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: GenerallColor.appBarBackGroundColor,
                  size: 60,
                ),
              );
            }
            if (state is AuthReadUserResponseState) {
              return state.readUser.fold((l) {
                return Center(
                  child: Text(
                    l,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                );
              }, (r) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        actions: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 60, left: 25),
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
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                                image: r.avatar == ''
                                    ? null
                                    : DecorationImage(
                                        image: NetworkImage(r.avatar),
                                        fit: BoxFit.cover),
                              ),
                              child: r.avatar == ''
                                  ? const Icon(
                                      CupertinoIcons.person,
                                      color: Colors.black,
                                      size: 30,
                                    )
                                  : null,
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
                              ),
                            ),
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
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    r.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${r.username}@',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
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
                            // ListTile(
                            //   leading: const Icon(
                            //     CupertinoIcons.game_controller_solid,
                            //     color: Colors.black54,
                            //   ),
                            //   onTap: () {},
                            //   title: const Text('سفارش های شما'),
                            // ),
                            const Divider(
                              color: Colors.grey,
                              height: .2,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.lightbulb,
                                color: Colors.black54,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: BlocProvider(
                                      create: (context) => TrickBloc()..add(TrickGetTrickUser()),
                                      child: const ClientTrickScreen(),
                                    ),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 200),
                                  ),
                                );
                              },
                              title: const Text(
                                'ترفند های شما',
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
                              onTap: () {
                                ShareManager.logout();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SplashScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
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
                );
              });
            }
            return Container();
          },
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
