import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authBloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/bloc/supportBloc/supportBloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickBloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickEvent.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/changeUserDetailsScreen.dart';
import 'package:game_hacks_chat/screens/clientTrickScreen.dart';
import 'package:game_hacks_chat/screens/registerScreen.dart';
import 'package:game_hacks_chat/screens/resetPasswordScreen.dart';
import 'package:game_hacks_chat/screens/splashScreen.dart';
import 'package:game_hacks_chat/screens/supportScreen.dart';
import 'package:game_hacks_chat/utilities/changeUserListen.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pushpole/pushpole.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (!ShareManager.getGust()) {
      BlocProvider.of<AuthBloc>(context).add(AuthReadUserEvent());
    }
    ChangeUserListen.changeUser.addListener(() {
      if (ChangeUserListen.changeUser.value) {
        BlocProvider.of<AuthBloc>(context).add(AuthReadUserEvent());
        ChangeUserListen.changeUser.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthReadUserErrorState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor:
                          GenerallColor.appBarBackGroundColor.withOpacity(.8),
                    ),
                    onPressed: () {
                      if (!ShareManager.getGust()) {
                        BlocProvider.of<AuthBloc>(context)
                            .add(AuthReadUserEvent());
                      }
                    },
                    child: const Text(
                      'تلاش مجدد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Text(state.errorText)
              ],
            );
          }
          if (state is AuthLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: GenerallColor.appBarBackGroundColor,
                size: 30,
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
                          padding: const EdgeInsets.only(bottom: 60, left: 25),
                          child: IconButton(
                            tooltip: 'ویرایش اطلاعات کاربر',
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: BlocProvider(
                                    create: (context) => AuthBloc(),
                                    child:
                                        ChangeUserDetailsScreen(userModel: r),
                                  ),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 200),
                                ),
                              );
                            },
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
                          CachedNetworkImage(
                            imageUrl: r.avatar,
                            errorWidget: (context, url, error) {
                              return Container(
                                  height: 80,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.person,
                                    color: Colors.black,
                                    size: 30,
                                  ));
                            },
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            },
                            placeholder: (context, url) {
                              return Container(
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.white24,
                                  shape: BoxShape.circle,
                                ),
                                child: LoadingAnimationWidget.fourRotatingDots(
                                  color: GenerallColor.appBarBackGroundColor,
                                  size: 20,
                                ),
                              );
                            },
                          ),

                          // Positioned(
                          //   top: 7,
                          //   left: 7,
                          //   child: Container(
                          //     height: 30,
                          //     width: 30,
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey.shade200,
                          //       shape: BoxShape.circle,
                          //       border: Border.all(
                          //         color: Colors.black,
                          //         width: 2,
                          //       ),
                          //     ),
                          //     child: const Icon(
                          //       CupertinoIcons.add,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
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
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: r.isBlocked,
                                      child: const Icon(
                                        Icons.block,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      r.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: r.verified,
                                      child: const Icon(
                                        Icons.verified,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
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
                          Visibility(
                            visible: !r.verified,
                            child: ListTile(
                              leading: const Icon(
                                CupertinoIcons.check_mark,
                                color: Colors.black54,
                              ),
                              onTap: () async {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(AuthVerifyEvent(r.email));
                                BlocProvider.of<AuthBloc>(context)
                                    .add(AuthReadUserEvent());
                                var idnotif = await PushPole.getId();
                                PushPole.sendSimpleNotifToUser(
                                  idnotif,
                                  'فعال سازی ایمیل',
                                  'لطفا ایمیل خود را چک کنین (هرزنامه) و پس از فعال سازی برنامه را بسته و باز کنین',
                                );
                              },
                              title: const Text('فعال سازی ایمیل شما'),
                            ),
                          ),
                          Visibility(
                            visible: !r.verified,
                            child: const Divider(
                              color: Colors.grey,
                              height: .2,
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.key,
                              color: Colors.black54,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: BlocProvider(
                                    create: (context) => AuthBloc(),
                                    child: ResetPassScreen(
                                      userModel: r,
                                    ),
                                  ),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 200),
                                ),
                              );
                            },
                            title: const Text('تغییر رمز عبور'),
                          ),
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
                                    create: (context) =>
                                        TrickBloc()..add(TrickGetTrickUser()),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: BlocProvider(
                                    create: (context) => SupportBloc(),
                                    child: const SupportScreen(),
                                  ),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 200),
                                ),
                              );
                            },
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
                              Icons.share_rounded,
                              color: Colors.black54,
                            ),
                            onTap: () {
                              Share.share(
                                'بیا از برنامه گیمک استفاده کن ! میتونی باهاش ترفند قرار بدی و ترفند های بقیه رو ببینی و دربارش نظر بدی ❤️',
                              );
                            },
                            title: const Text(
                              'برنامه رو معرفی کنید',
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

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
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
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.person_crop_circle,
                          color: Colors.black,
                          size: 40,
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
                        children: const [
                          Text(
                            'کاربر مهمان',
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
                          CupertinoIcons.bubble_left_fill,
                          color: Colors.black54,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: BlocProvider(
                                create: (context) => SupportBloc(),
                                child: const SupportScreen(),
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 200),
                            ),
                          );
                        },
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
                          Icons.share_rounded,
                          color: Colors.black54,
                        ),
                        onTap: () {
                          Share.share(
                            'بیا از برنامه گیمک استفاده کن ! میتونی باهاش ترفند قرار بدی و ترفند های بقیه رو ببینی و دربارش نظر بدی ❤️',
                          );
                        },
                        title: const Text(
                          'برنامه رو معرفی کنید',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: .2,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:
                            GenerallColor.appBarBackGroundColor.withOpacity(.8),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthBloc(),
                              child: const RegisterScreen(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'ثبت نام',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
