import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 65,
            backgroundColor: GenerallColor.appBarBackGroundColor,
            centerTitle: true,
            title: const Text(
              'آیتم ها',
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
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: .5,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        stops: [.15, 1],
                        end: Alignment.bottomCenter,
                        begin: Alignment.center,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //TODO FIX HERE **************
                        const Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: .8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
