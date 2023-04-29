import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/bannerDetalsBloc/bannerDetailsBloc.dart';
import 'package:game_hacks_chat/bloc/categoryBloc/categoryBloc.dart';
import 'package:game_hacks_chat/bloc/gameDetailBloc/gameDetailBloc.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeBloc.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeEvent.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/categoryModel.dart';
import 'package:game_hacks_chat/screens/bannerDetailsScreen.dart';
import 'package:game_hacks_chat/screens/categoryGameScreen.dart';
import 'package:game_hacks_chat/screens/gameScreen.dart';
import 'package:game_hacks_chat/widget/singleItem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
    BlocProvider.of<HomeBloc>(context).add(HomeRequestEvent());
    _bannerPageController = PageController(viewportFraction: .8);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: GenerallColor.appBarBackGroundColor,
                size: 30,
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                toolbarHeight: 100,
                centerTitle: false,
                backgroundColor: GenerallColor.appBarBackGroundColor,
                title: const Text(
                  'به برنامه گیمک خوش اومدین',
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
                      child: state is HomeResponseState
                          ? state.readUser.fold((l) {
                              return Text(
                                l,
                                style: const TextStyle(fontSize: 18),
                              );
                            }, (r) {
                              return Text(
                                r.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              );
                            })
                          : null,
                    ),
                  ),
                ),
              ),

              //TODO Seling Items
              // if (state is HomeResponseState) ...{
              //   state.getAllBanner.fold((l) {
              //     return SliverToBoxAdapter(
              //       child: Text(
              //         l,
              //         style: const TextStyle(fontSize: 18),
              //       ),
              //     );
              //   }, (r) {
              //     return r.isNotEmpty
              //         ? SliverToBoxAdapter(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Padding(
              //                   padding: EdgeInsets.only(right: 55),
              //                   child: Text(
              //                     'پیشنهاد ها',
              //                     style: TextStyle(
              //                       fontSize: 16,
              //                       fontFamily: 'vazirm',
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 6,
              //                 ),
              //                 SizedBox(
              //                   height: 170,
              //                   width: double.infinity,
              //                   child: Stack(
              //                     children: [
              //                       PageView.builder(
              //                         itemCount: r.length,
              //                         controller: _bannerPageController,
              //                         itemBuilder: (context, index) {
              //                           return GestureDetector(
              //                             onTap: () {
              //                               Navigator.push(
              //                                 context,
              //                                 PageTransition(
              //                                   child: BlocProvider(
              //                                     create: (context) =>
              //                                         BannerDetailsBloc(),
              //                                     child: BannerDetailsScreen(
              //                                       bannerModel: r[index],
              //                                     ),
              //                                   ),
              //                                   type: PageTransitionType.fade,
              //                                   duration: const Duration(
              //                                       milliseconds: 200),
              //                                 ),
              //                               );
              //                             },
              //                             child: Container(
              //                               decoration: BoxDecoration(
              //                                 color: Colors.black12,
              //                                 borderRadius:
              //                                     BorderRadius.circular(20),
              //                               ),
              //                               margin: const EdgeInsets.only(
              //                                 right: 10,
              //                               ),
              //                               child: Row(
              //                                 children: [
              //                                   CachedNetworkImage(
              //                                     imageUrl: r[index].image,
              //                                     placeholder: (context, url) {
              //                                       return SizedBox(
              //                                         height: double.infinity,
              //                                         width: 140,
              //                                         child: Center(
              //                                           child:
              //                                               LoadingAnimationWidget
              //                                                   .fourRotatingDots(
              //                                             color: GenerallColor
              //                                                 .appBarBackGroundColor,
              //                                             size: 20,
              //                                           ),
              //                                         ),
              //                                       );
              //                                     },
              //                                     errorWidget:
              //                                         (context, url, error) {
              //                                       return const SizedBox(
              //                                         height: double.infinity,
              //                                         width: 140,
              //                                         child: Center(
              //                                           child: Text(
              //                                               'خطای بارگذاری عکس'),
              //                                         ),
              //                                       );
              //                                     },
              //                                     imageBuilder:
              //                                         (context, imageProvider) {
              //                                       return SizedBox(
              //                                         height: double.infinity,
              //                                         width: 140,
              //                                         child: Image(
              //                                           image: imageProvider,
              //                                           fit: BoxFit.contain,
              //                                         ),
              //                                       );
              //                                     },
              //                                   ),
              //                                   const SizedBox(
              //                                     width: 10,
              //                                   ),
              //                                   Expanded(
              //                                     child: Text(
              //                                       r[index].title,
              //                                       style: const TextStyle(
              //                                           fontSize: 16,
              //                                           fontFamily: 'vazirm'),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           );
              //                         },
              // ),
              //       Visibility(
              //         visible: r.length > 1,
              //         child: Positioned(
              //           bottom: 4,
              //           left: 0,
              //           right: 0,
              //           child: Center(
              //             child: SmoothPageIndicator(
              //               controller: _bannerPageController,
              //               count: r.length,
              //               effect: const ScrollingDotsEffect(
              //                 fixedCenter: true,
              //                 activeDotColor: Colors.black,
              //                 dotColor: Colors.white,
              //                 dotHeight: 12,
              //                 dotWidth: 12,
              //                 spacing: 10,
              //               ),
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // ],
              // ),
              // )
              // : const SliverToBoxAdapter(
              //     child: Spacer(),
              //   );
              // }),
              // },
              if (state is HomeResponseState) ...{
                state.getAllCategory.fold((l) {
                  return Text(
                    l,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  );
                }, (r) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    sliver: SliverToBoxAdapter(
                      child: categoryItem(categoryModel: r),
                    ),
                  );
                }),
              },
              if (state is HomeResponseState) ...{
                state.popularGame.fold((l) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        l,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }, (r) {
                  return SliverToBoxAdapter(
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
                            itemCount: r.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: r[index].imaheBanner,
                                imageBuilder: (context, imageProvider) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          child: BlocProvider(
                                            create: (context) =>
                                                GameDetailsBloc(),
                                            child: GameScreen(
                                              gameProductModel: r[index],
                                            ),
                                          ),
                                          type: PageTransitionType.fade,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          // isIos: true,
                                          reverseDuration:
                                              const Duration(milliseconds: 200),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: index == 0 ? 25 : 15,
                                          left: index == r.length - 1 ? 10 : 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 330,
                                    ),
                                  );
                                },
                                placeholder: (context, url) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      right: index == 0 ? 25 : 15,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 330,
                                    child: LoadingAnimationWidget.fallingDot(
                                      color:
                                          GenerallColor.appBarBackGroundColor,
                                      size: 26,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      right: index == 0 ? 25 : 15,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 330,
                                    child: const Text(
                                      'مشکل در بارگذاری عکس',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'vazirm',
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                })
              },
              const SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    bottom: 10,
                    left: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'بازی های جدید',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'vazirm',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: GenerallColor.appBarBackGroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'بیشتر',
                          style: TextStyle(
                            fontFamily: 'vazirm',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is HomeResponseState) ...{
                state.newGames.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(
                      l,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }, (r) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: index == 0 ? 10 : 15, left: 20, right: 20),
                          child: singleItemGame(
                            gameProductModel: r[index],
                          ),
                        );
                      },
                      childCount: r.length < 5 ? r.length : 5,
                    ),
                  );
                }),
              },
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20, bottom: 10, left: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'بازی های آپدیت شده',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'vazirm',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            backgroundColor:
                                GenerallColor.appBarBackGroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {},
                        child: const Text(
                          'بیشتر',
                          style: TextStyle(
                            fontFamily: 'vazirm',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is HomeResponseState) ...{
                state.games.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(
                      l,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }, (r) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: index == 0 ? 10 : 15, left: 20, right: 20),
                          child: singleItemGame(
                            gameProductModel: r[index],
                          ),
                        );
                      },
                      childCount: r.length < 5 ? r.length : 5,
                    ),
                  );
                }),
              },
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 160),
              ),
            ],
          );
        },
      )),
    );
  }
}

class categoryItem extends StatelessWidget {
  categoryItem({
    super.key,
    required this.categoryModel,
  });
  List<CategoryModel> categoryModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryModel.length,
        itemBuilder: (context, index) {
          var singleCat = categoryModel[index];
          String categoryColor = 'ff${singleCat.color}';
          int hexColor = int.parse(categoryColor, radix: 16);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: BlocProvider(
                    create: (context) => CategoryBloc(),
                    child: CategoryGameScreen(
                      categoryModel: categoryModel[index],
                    ),
                  ),
                  type: PageTransitionType.fade,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                  right: index == 0 ? 20 : 15,
                  left: index == categoryModel.length - 1 ? 10 : 0),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(hexColor).withOpacity(.7),
                        borderRadius: BorderRadius.circular(20)),
                    width: 70,
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image(
                        image: NetworkImage(singleCat.image),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    singleCat.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
