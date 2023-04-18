import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/bannerDetalsBloc/bannerDetailsBloc.dart';
import 'package:game_hacks_chat/bloc/bannerDetalsBloc/bannerDetailsEvent.dart';
import 'package:game_hacks_chat/bloc/bannerDetalsBloc/bannerDetailsState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:game_hacks_chat/screens/sellItemScreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerDetailsScreen extends StatefulWidget {
  BannerDetailsScreen({super.key, required this.bannerModel});
  BannerModel bannerModel;

  @override
  State<BannerDetailsScreen> createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BannerDetailsBloc>(context)
        .add(BannerDetailsRequestEvent(widget.bannerModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BannerDetailsBloc, BannerDetailsState>(
        builder: (context, state) {
          if (state is BannerDetailsLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: GenerallColor.appBarBackGroundColor,
                size: 30,
              ),
            );
          }
          if (state is BannerDetailsresponseState) {
            return state.bannerDetails.fold((l) {
              return Center(
                child: Text(
                  l,
                  style: const TextStyle(fontSize: 20, fontFamily: 'vazirm'),
                ),
              );
            }, (r) {
              if (r.isEmpty) {
                return const Center(
                  child:
                      Text('متاسفانه اکنون آیتمی برای این بازی موجود نیست'),
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      toolbarHeight: 65,
                      backgroundColor: GenerallColor.appBarBackGroundColor,
                      centerTitle: true,
                      title: Text(
                        widget.bannerModel.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'vazirm',
                          color: Colors.white,
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.forward,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                      leading: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 4,
                      ),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: SellItemScreen(
                                      bannerModel: widget.bannerModel),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 200),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Column(children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/test2.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(16),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: const [
                                        Center(
                                          child: Text(
                                            'اسم ایتم',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              fontFamily: 'vazirm',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            'قیمت : ۱۰۰۰۰۰',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            'قیمت با تخفیف : ۹۰۰۰۰',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        }, childCount: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: .8,
                        ),
                      ),
                    ),
                  ],
                );
              }
            });
          }
          return Container();
        },
      ),
    );
  }
}
