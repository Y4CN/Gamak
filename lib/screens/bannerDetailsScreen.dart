import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BannerDetailsScreen extends StatefulWidget {
  BannerDetailsScreen({super.key, required this.bannerModel});
  BannerModel bannerModel;

  @override
  State<BannerDetailsScreen> createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
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
                    imageUrl: widget.bannerModel.image,
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
                    widget.bannerModel.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
