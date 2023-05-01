import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_hacks_chat/bloc/gameDetailBloc/gameDetailBloc.dart';
import 'package:game_hacks_chat/bloc/gameDetailBloc/gameDetailEvent.dart';
import 'package:game_hacks_chat/bloc/gameDetailBloc/gameDetailState.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickBloc.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/screens/trickListScreen.dart';
import 'package:game_hacks_chat/widget/singlePic.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.gameProductModel});
  GameProductModel gameProductModel;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GameDetailsBloc>(context)
        .add(GameDetailsRequestEvent(widget.gameProductModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameDetailsBloc, GameDetailsState>(
        builder: (context, state) {
          if (state is GameDetailsLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: GenerallColor.appBarBackGroundColor, size: 30),
            );
          }
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: SliverAppBar(
                      backgroundColor: GenerallColor.appBarBackGroundColor,
                      toolbarHeight: 200,
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 120, right: 10),
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
                                  color: GenerallColor.primaryColor
                                      .withOpacity(.6),
                                ),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.back,
                                    color: GenerallColor.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            //TODO here is Menu bar for games

                            // Container(
                            //   height: 50,
                            //   width: 50,
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     color:
                            //         GenerallColor.primaryColor.withOpacity(.6),
                            //   ),
                            //   child: const Center(
                            //     child: Icon(
                            //       CupertinoIcons.ellipsis_vertical,
                            //       color: GenerallColor.primaryColor,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.gameProductModel.imaheBanner,
                              imageBuilder: (context, imageProvider) {
                                return Image(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: (context, url) {
                                return Center(
                                  child:
                                      LoadingAnimationWidget.fourRotatingDots(
                                    color: GenerallColor.appBarBackGroundColor,
                                    size: 30,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return const Center(
                                  child: Text(
                                    'مشکل در بارگذاری عکس',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'vazirm',
                                    ),
                                  ),
                                );
                              },
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
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                                imageUrl: widget.gameProductModel.image,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain),
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                },
                                placeholder: (context, url) {
                                  return Container(
                                    height: 75,
                                    width: 75,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                      color:
                                          GenerallColor.appBarBackGroundColor,
                                      size: 20,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Container(
                                    height: 75,
                                    width: 75,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'مشکل در بارگذاری عکس',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'vazirm',
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.gameProductModel.name,
                                    style: const TextStyle(
                                        fontSize: 16, fontFamily: 'vazirm'
                                        // fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 5),
                                  RatingBar(
                                    direction: Axis.horizontal,
                                    glow: false,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemSize: 18,
                                    initialRating:
                                        widget.gameProductModel.rate.toDouble(),
                                    maxRating: 5,
                                    updateOnDrag: false,
                                    ratingWidget: RatingWidget(
                                        full: Icon(
                                          CupertinoIcons.star_fill,
                                          color: Colors.yellow.shade800,
                                        ),
                                        half: const SizedBox(),
                                        empty: Icon(
                                          CupertinoIcons.star,
                                          color: Colors.grey.shade500,
                                        )),
                                    onRatingUpdate: (value) {},
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              splashRadius: 15,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: BlocProvider(
                                      create: (context) => TrickBloc(),
                                      child: TrickListScreen(
                                        gameProductModel:
                                            widget.gameProductModel,
                                      ),
                                    ),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 200),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.lightbulb_outline_rounded,
                                color: Colors.amber.shade600,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state is GameDetailsResponseState) ...{
                    state.platform.fold((l) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            l,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'vazirm',
                            ),
                          ),
                        ),
                      );
                    }, (r) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        sliver: SliverToBoxAdapter(
                          child: Visibility(
                            visible: r.isNotEmpty,
                            child: SizedBox(
                              height: 35,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: r.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: index == 0 ? 12 : 7),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Text(
                                      r[index].platform,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  },
                  if (state is GameDetailsResponseState) ...{
                    state.decription.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              l,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                      (r) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: ExpandableText(
                              r.description,
                              expandText: 'بیش تر',
                              collapseText: 'کم تر',
                              maxLines: 3,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      },
                    ),
                  },
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 8, horizontal: 12),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           height: 55,
                  //           width: 55,
                  //           decoration: BoxDecoration(
                  //             color: Colors.grey.shade300,
                  //             shape: BoxShape.circle,
                  //           ),
                  //           child: const Center(
                  //             child: Icon(
                  //               CupertinoIcons.chat_bubble,
                  //               color: Colors.black,
                  //               size: 20,
                  //               shadows: [
                  //                 BoxShadow(
                  //                   color: Colors.black,
                  //                   blurRadius: 2,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           width: 5,
                  //         ),
                  //         const Text(
                  //           '10K',
                  //           style: TextStyle(fontSize: 16),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  if (state is GameDetailsResponseState) ...{
                    state.images.fold((l) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(l,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'vazirm')),
                        ),
                      );
                    }, (r) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: SinglePicture(image: r[index].image),
                                      type: PageTransitionType.fade,
                                      duration: const Duration(milliseconds: 200),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl: r[index].image,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.scaleDown,
                                          )),
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.black12,
                                      ),
                                      alignment: Alignment.center,
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                        color:
                                            GenerallColor.appBarBackGroundColor,
                                        size: 26,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.black12,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'مشکل در بارگذاری عکس',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: 'vazirm'),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            childCount: r.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: .9,
                          ),
                        ),
                      );
                    }),
                  },
                  const SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: 120,
                    ),
                  )
                ],
              ),
              // Positioned(
              //   bottom: 50,
              //   right: 20,
              //   left: 20,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       surfaceTintColor: Colors.transparent,
              //       shadowColor: Colors.white,
              //       elevation: 20,
              //       backgroundColor: Colors.green.shade300,
              //       minimumSize: const Size(double.infinity, 50),
              //       shape: RoundedRectangleBorder(
              //         side: const BorderSide(
              //           color: Colors.black,
              //           width: 2,
              //           strokeAlign: .1,
              //         ),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     onPressed: () {},
              //     child: const Text(
              //       'خرید مستقیم بازی',
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontFamily: 'vazirm',
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // )
            ],
          );
        },
      ),
    );
  }
}
