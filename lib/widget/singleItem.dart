import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/screens/gameScreen.dart';
import 'package:game_hacks_chat/screens/trickListScreen.dart';
import 'package:page_transition/page_transition.dart';

class singleItemGame extends StatelessWidget {
  const singleItemGame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: const GameScreen(),
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
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name Game',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w600,
                        fontFamily: 'robotom'),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Category Game',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Icon(
                    CupertinoIcons.star,
                    color: Colors.yellow.shade800,
                    size: 20,
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
