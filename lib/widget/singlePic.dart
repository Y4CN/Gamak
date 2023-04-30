import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';




class SinglePicture extends StatelessWidget {
  SinglePicture({super.key, required this.image});
  String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black.withOpacity(.8),
        alignment: Alignment.center,
        child: CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) {
            return InteractiveViewer(
              clipBehavior: Clip.none,
              child: Container(
                height: 250,
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
              ),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              height: 250,
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
              height: 250,
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
        ),
      ),
    );
  }
}

