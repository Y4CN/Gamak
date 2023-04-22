import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickBloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickEvent.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/data/model/trickCommendModel.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrickSingleScreen extends StatefulWidget {
  TrickSingleScreen(
      {super.key, required this.trickModel, required this.gameProductModel});
  TrickModel trickModel;
  GameProductModel gameProductModel;

  @override
  State<TrickSingleScreen> createState() => _TrickSingleScreenState();
}

class _TrickSingleScreenState extends State<TrickSingleScreen> {
  late PageController _pageController;
  late TextEditingController _commendController;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TrickBloc>(context)
        .add(TrickRequestCommedEvent(widget.trickModel.id));
    _pageController = PageController(viewportFraction: .8);
    _commendController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocBuilder<TrickBloc, TrickState>(
          builder: (context, state) {
            return CustomScrollView(
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
                          const SizedBox(),
                        ],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.gameProductModel.imaheBanner,
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
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      widget.trickModel.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ExpandableText(
                      widget.trickModel.description,
                      style: const TextStyle(wordSpacing: 1),
                      expandText: 'بیشتر',
                      collapseText: 'کم تر',
                      maxLines: 10,
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Container(
                //     margin: const EdgeInsets.symmetric(
                //       vertical: 10,
                //       horizontal: 10,
                //     ),
                //     height: 80,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(15),
                //       border: Border.all(
                //         color: Colors.black54,
                //         width: 1,
                //       ),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 15),
                //       child: Row(
                //         children: const [
                //           CircleAvatar(
                //             radius: 30,
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(
                //               right: 10,
                //             ),
                //             child: Text(
                //               'Author',
                //               style: TextStyle(
                //                 fontSize: 16,
                //               ),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: widget.trickModel.images.isNotEmpty,
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: widget.trickModel.images.length,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: widget.trickModel.images[index],
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: const Text(
                                      'مشکل در بارگذاری عکس',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) {
                                  return Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                      color:
                                          GenerallColor.appBarBackGroundColor,
                                      size: 20,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Positioned(
                            bottom: 25,
                            right: 0,
                            left: 0,
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: widget.trickModel.images.length,
                                effect: const WormEffect(
                                  dotColor: Colors.white,
                                  activeDotColor: Colors.black,
                                  dotHeight: 12,
                                  dotWidth: 12,
                                  type: WormType.thin,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'نظرات :‌',
                      style: TextStyle(fontSize: 20, fontFamily: 'vazirm'),
                    ),
                  ),
                ),
                if (state is TrickLoadingSingleState) ...{
                  SliverToBoxAdapter(
                    child: Center(
                      child: LoadingAnimationWidget.fallingDot(
                          color: GenerallColor.appBarBackGroundColor, size: 20),
                    ),
                  )
                },
                if (state is TrickResponseSingleState) ...{
                  state.trickCommends.fold((l) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          l,
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'vazirm'),
                        ),
                      ),
                    );
                  }, (r) {
                    if (r.isEmpty) {
                      return const SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              'نظری برای این ترفند قبت نشده اولین نفری باشین که نظر میدین',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'vazirm'),
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey,
                                spreadRadius: -1,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      minRadius: 20,
                                      backgroundImage: NetworkImage(
                                          r[index].userModel.avatar),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      r[index].userModel.name,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const Spacer(),
                                    Visibility(
                                      visible: ShareManager.readUserId() ==
                                          r[index].userModel.id,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(CupertinoIcons.pen,
                                            color: Colors.green),
                                      ),
                                    ),
                                    Visibility(
                                      visible: ShareManager.readUserId() ==
                                          r[index].userModel.id,
                                      child: state is TrickLodingDeleteState
                                          ? LoadingAnimationWidget
                                              .fourRotatingDots(
                                                  color: GenerallColor
                                                      .appBarBackGroundColor,
                                                  size: 12)
                                          : IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  useSafeArea: true,
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return BlocProvider(
                                                      create: (context) =>
                                                          TrickBloc(),
                                                      child: _CustomDialog(
                                                        trickModel:
                                                            widget.trickModel,
                                                        trickCommendModel:
                                                            r[index],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(9),
                                child: Text(
                                  r[index].commend,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        );
                      }, childCount: r.length),
                    );
                  })
                },
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 70),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<TrickBloc, TrickState>(
          builder: (context, state) {
            if (state is TrickResponseCommendState) {
              state.trickCommend.fold((l) {
                CustomSnakBar.getCustomSnakBar(l, context);
              }, (r) {
                if (r) {
                  //TODO Test On Server couse here is TOO Fast and Error for Rebuild

                  // CustomSnakBar.getCustomSnakBar(
                  // 'نظر شما با موفقیت ثبت شد ❤️', context);
                  BlocProvider.of<TrickBloc>(context)
                      .add(TrickRequestCommedEvent(widget.trickModel.id));
                }
              });
            }
            return SafeArea(
              child: Container(
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _commendController,
                  onSubmitted: (value) {
                    BlocProvider.of<TrickBloc>(context).add(
                      TrickSendCommendEvent(
                        value,
                        widget.trickModel.id,
                      ),
                    );
                    _commendController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    suffixIcon: state is TrickLoadingCommendState
                        ? LoadingAnimationWidget.fallingDot(
                            color: GenerallColor.appBarBackGroundColor,
                            size: 16)
                        : IconButton(
                            onPressed: () {
                              BlocProvider.of<TrickBloc>(context).add(
                                TrickSendCommendEvent(
                                  _commendController.text.trim(),
                                  widget.trickModel.id,
                                ),
                              );
                              _commendController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            icon: const Icon(
                              CupertinoIcons.arrow_uturn_left,
                            ),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    labelText: 'نظر خودتون رو بنویسید',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'vazirm',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CustomDialog extends StatelessWidget {
  _CustomDialog({
    super.key,
    required this.trickCommendModel,
    required this.trickModel,
  });
  TrickCommendModel trickCommendModel;
  TrickModel trickModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: GenerallColor.primaryColor,
      shadowColor: GenerallColor.primaryColor,
      surfaceTintColor: Colors.white,
      elevation: 10,
      scrollable: false,
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'آيا مطمئن هستین که میخواهید این نظر را پاک کنین ؟',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: const Text(
        'پاک کردن نظر',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(70, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: GenerallColor.appBarBackGroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'خیر',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'vazirm',
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(70, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: GenerallColor.appBarBackGroundColor),
          onPressed: () {
            BlocProvider.of<TrickBloc>(context).add(
              TrickDeleteEvent(trickCommendModel.id),
            );
            
            Navigator.pop(context);
          },
          child: const Text(
            'بله',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'vazirm',
            ),
          ),
        ),
      ],
    );
  }
}
