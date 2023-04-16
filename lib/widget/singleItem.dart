import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/screens/gameScreen.dart';
import 'package:game_hacks_chat/screens/homeScreen.dart';
import 'package:game_hacks_chat/screens/trickListScreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class singleItemGame extends StatelessWidget {
  singleItemGame({super.key, required this.gameProductModel});
  GameProductModel gameProductModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: GameScreen(
              gameProductModel: gameProductModel,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 200),
            // isIos: true,
            reverseDuration: const Duration(milliseconds: 200),
          ),
        );
      },
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: gameProductModel.image,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      )),
                );
              },
              placeholder: (context, url) {
                return Container(
                  height: 75,
                  width: 75,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: GenerallColor.appBarBackGroundColor,
                    size: 20,
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  height: 75,
                  width: 75,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'خطای بارگذاری عکس',
                    style: TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gameProductModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.w600,
                      fontFamily: 'vazirm',
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    gameProductModel.categoryModel.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  RatingBar(
                    direction: Axis.horizontal,
                    glow: false,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 18,
                    initialRating: gameProductModel.rate.toDouble(),
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
                    child: const TrickListScreen(),
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
    );
  }
}
