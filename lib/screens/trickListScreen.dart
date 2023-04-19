import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/screens/trickSingleScreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class TrickListScreen extends StatelessWidget {
  TrickListScreen({super.key, required this.gameProductModel});
  GameProductModel gameProductModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: GenerallColor.primaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.forward,
                    size: 26,
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'NAme Game',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'vazirm',
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    right: 6,
                    left: 6,
                  ),
                  child: ListTile(
                    leading: CachedNetworkImage(
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
                    tileColor: Colors.white30,
                    splashColor: GenerallColor.primaryColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const TrickSingleScreen(),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 200),
                        ),
                      );
                    },
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: .2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    title: const Text(
                      'Title Trick',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      'Author',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
