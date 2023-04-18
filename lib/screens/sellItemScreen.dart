import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/bannerDetalsModel.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SellItemScreen extends StatefulWidget {
  SellItemScreen({
    super.key,
    required this.bannerModel,
    required this.bannerDetailsModel,
  });
  BannerModel bannerModel;
  BannerDetailsModel bannerDetailsModel;

  @override
  State<SellItemScreen> createState() => _SellItemScreenState();
}

class _SellItemScreenState extends State<SellItemScreen> {
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100,
            backgroundColor: GenerallColor.appBarBackGroundColor,
            centerTitle: true,
            title: const Text(
              'جزئیات',
              style: TextStyle(
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
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 15),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.bannerDetailsModel.image,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                          border: Border.all(
                            color: Colors.black45,
                            width: .3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      return Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                            width: .3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: GenerallColor.appBarBackGroundColor,
                          size: 20,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                              width: .3,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('خطای بارگذاری'));
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.bannerDetailsModel.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: ExpandableText(
                'adadadadadsadsajdajdjsajdjffffffkfkkfkfkfkfkfkfkfkfkfadadadadadadaadadadadadandadajdjajdajdjadjajdjadjajdjadjajdajdjajdajdjadjajdjadjajdjadjajdajdjajdajdjajdajdjajdajdjajdjajdjajdjsajdjsajdakfkskfdskfkskdfkskfsllaldaldloqoeoqeoqoewieiweiwiewepwpepqpeqpepqprpprepwprpwr[er[w[[ew]rw][rwe]r]w]r]ewt[wtp]',
                expandText: 'بیشتر',
                maxLines: 4,
                style: TextStyle(
                  fontSize: 16,
                ),
                collapseText: 'کم تر',
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12)),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const SwapEffect(
                    dotColor: Colors.black12,
                    activeDotColor: Colors.black,
                    dotHeight: 13,
                    dotWidth: 13,
                    type: SwapType.zRotation),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
