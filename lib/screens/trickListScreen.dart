import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickBloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickEvent.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/screens/addTrickScreen.dart';
import 'package:game_hacks_chat/screens/trickSingleScreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class TrickListScreen extends StatefulWidget {
  TrickListScreen({super.key, required this.gameProductModel});
  GameProductModel gameProductModel;

  @override
  State<TrickListScreen> createState() => _TrickListScreenState();
}

class _TrickListScreenState extends State<TrickListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TrickBloc>(context)
        .add(TrickRequestEvent(widget.gameProductModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TrickBloc, TrickState>(
        builder: (context, state) {
          return CustomScrollView(
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
                title: Text(
                  widget.gameProductModel.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'vazirm',
                  ),
                ),
              ),
              if (state is TrickResponseState) ...{
                state.trickLst.fold((l) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        l,
                        style:
                            const TextStyle(fontSize: 18, fontFamily: 'vazirm'),
                      ),
                    ),
                  );
                }, (r) {
                  if (r.isEmpty) {
                    return const SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            'متاسفانه هنوز ترفندی برای این بازی ارائه نشده شما اولین نفری باشین که ترفند این بازی رو قرار میدین برای این کار روی دکمه پایین کلیک کنین',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'vazirm'),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                            left: 10,
                          ),
                          child: ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: widget.gameProductModel.image,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
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
                                  child:
                                      LoadingAnimationWidget.fourRotatingDots(
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
                                  child: BlocProvider(
                                    create: (context) => TrickBloc(),
                                    child: TrickSingleScreen(
                                      trickModel: r[index],
                                      gameProductModel: widget.gameProductModel,
                                    ),
                                  ),
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
                            title: Text(
                              r[index].title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              r[index].userModel.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: r.length,
                    ),
                  );
                }),
              },
              const SliverPadding(
                padding: EdgeInsets.only(
                  bottom: 70,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        autofocus: false,
        backgroundColor: GenerallColor.appBarBackGroundColor,
        elevation: 6,
        isExtended: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide.none,
        ),
        tooltip: 'اضافه کردن ترفند',
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: BlocProvider(
                create: (context) => TrickBloc(),
                child: AddTrickScreen(
                  gameProductModel: widget.gameProductModel,
                ),
              ),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 200),
            ),
          );
        },
        label: const Text(
          'ترفند اضافه کن !',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
