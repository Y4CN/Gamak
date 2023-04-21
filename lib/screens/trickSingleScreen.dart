import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
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
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: .8);
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
            Directionality(
              textDirection: TextDirection.ltr,
              child: SliverAppBar(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  )),
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
                              child: LoadingAnimationWidget.fourRotatingDots(
                                color: GenerallColor.appBarBackGroundColor,
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
                              type: WormType.thin),
                        ),
                      ),
                    ),
                  ],
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 8, right: 10, left: 10),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              minRadius: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Name Commenter',
                              style: TextStyle(fontSize: 12),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.pen,
                                  color: Colors.green),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'commentcadadadadasd;agilahfgaiucasgigaifugiusajbkfvabiugffipowqipeiwqruqwyueiquewqporopwqtwe[t[worewpripouaposaoidafalkgjlah]]',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: 10),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 70),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            width: double.infinity,
            height: 80,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            alignment: Alignment.center,
            child: TextField(
              onSubmitted: (value) {
                //TODO submit is HERE
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.arrow_uturn_left,
                    )),
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
        ),
      ),
    );
  }
}
