import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickBloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickEvent.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/data/model/trickCommendModel.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';
import 'package:game_hacks_chat/widget/customSnakBar.dart';
import 'package:game_hacks_chat/widget/singlePic.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
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
  late TextEditingController _commendController;
  late ValueNotifier _editValueNotivier;
  late bool _isEdit;
  late String _commendId;
  late ScrollController _scrollController;
  late int page;
  late ValueNotifier deleteNotif;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TrickBloc>(context)
        .add(TrickRequestCommedEvent(widget.trickModel.id, 1));
    _pageController = PageController(viewportFraction: .8);
    _commendController = TextEditingController();
    _isEdit = false;
    _editValueNotivier = ValueNotifier<String>('');
    _commendId = '';
    page = 1;
    _scrollController = ScrollController();
    deleteNotif = ValueNotifier<bool>(false);
    deleteNotif.addListener(() {
      if (deleteNotif.value) {
        BlocProvider.of<TrickBloc>(context)
            .add(TrickRequestCommedEvent(widget.trickModel.id, page));
        deleteNotif.value = false;
      }
    });
    // ..addListener(
    //   () {
    //     // print('listen');
    //     if (_scrollController.position.atEdge) {
    //       bool isTop = _scrollController.position.pixels == 0;
    //       if (!isTop) {
    //         BlocProvider.of<TrickBloc>(context)
    //             .add(TrickRequestCommedEvent(widget.trickModel.id, page++));
    //       }
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocBuilder<TrickBloc, TrickState>(
          builder: (context, state) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SliverAppBar(
                    backgroundColor: GenerallColor.appBarBackGroundColor,
                    toolbarHeight: 200,
                    automaticallyImplyLeading: false,
                    title: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 120, right: 10),
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
                                color:
                                    GenerallColor.primaryColor.withOpacity(.6),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: widget.trickModel.images.isNotEmpty,
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: widget.trickModel.images.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: SinglePicture(
                                          image:
                                              widget.trickModel.images[index]),
                                      type: PageTransitionType.fade,
                                      duration:
                                          const Duration(milliseconds: 200),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl: widget.trickModel.images[index],
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
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
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                        color:
                                            GenerallColor.appBarBackGroundColor,
                                        size: 20,
                                      ),
                                    );
                                  },
                                ),
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
                                  type: WormType.thin,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 20,
                            backgroundImage: NetworkImage(
                              widget.trickModel.userModel.avatar,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Text(
                              'نویسنده : ${widget.trickModel.userModel.name}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
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
                if (state is TrickLoadingSingleState) ...{
                  SliverToBoxAdapter(
                    child: Center(
                      child: LoadingAnimationWidget.fallingDot(
                          color: GenerallColor.appBarBackGroundColor, size: 20),
                    ),
                  )
                },
                if (state is TrickResponseSingleState) ...{
                  state.trickCommends.fold((l) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          l,
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'vazirm'),
                        ),
                      ),
                    );
                  }, (r) {
                    if (r.isEmpty) {
                      return const SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                              'نظری برای این ترفند قبت نشده اولین نفری باشین که نظر میدین',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'vazirm'),
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 30) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      GenerallColor.appBarBackGroundColor,
                                  minimumSize: const Size(double.infinity, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  BlocProvider.of<TrickBloc>(context).add(
                                    TrickRequestCommedEvent(
                                      widget.trickModel.id,
                                      ++page,
                                    ),
                                  );
                                  _scrollController.animateTo(
                                    10,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.linear,
                                  );
                                },
                                child: const Text(
                                  'صفحه بعدی',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'vazirm',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 8,
                              right: 10,
                              left: 10,
                            ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        minRadius: 20,
                                        backgroundColor: GenerallColor
                                            .appBarBackGroundColor
                                            .withOpacity(.6),
                                        backgroundImage: NetworkImage(
                                          r[index].userModel.avatar,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        r[index].userModel.name,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Visibility(
                                        visible: ShareManager.readUserId() ==
                                            r[index].userModel.id,
                                        child: IconButton(
                                          onPressed: () {
                                            _commendController.text =
                                                r[index].commend;
                                            _isEdit = true;
                                            _commendId = r[index].id;
                                            _editValueNotivier.value =
                                                _commendController.text;
                                            _editValueNotivier
                                                .notifyListeners();
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.pen,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: ShareManager.readUserId() ==
                                            r[index].userModel.id,
                                        child: deletIconStatus(
                                            context,
                                            widget.trickModel,
                                            r[index],
                                            page,
                                            deleteNotif),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Text(
                                    r[index].commend,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: r.length == 30 ? r.length + 1 : r.length,
                      ),
                    );
                  })
                },
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 40),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BlocBuilder<TrickBloc, TrickState>(
            builder: (context, state) {
              if (state is TrickUpdateResponseState) {
                state.updateResponse.fold((l) {
                  CustomSnakBar.getCustomSnakBar(l, context);
                }, (r) {
                  if (r) {
                    BlocProvider.of<TrickBloc>(context)
                        .add(TrickRequestCommedEvent(widget.trickModel.id, 1));
                  }
                });
              }
              if (state is TrickResponseCommendState) {
                state.trickCommend.fold((l) {
                  CustomSnakBar.getCustomSnakBar(l, context);
                }, (r) {
                  if (r) {
                    //TODO Test On Server couse here is TOO Fast and Error for Rebuild

                    // CustomSnakBar.getCustomSnakBar(
                    // 'نظر شما با موفقیت ثبت شد ❤️', context);
                    BlocProvider.of<TrickBloc>(context).add(
                      TrickRequestCommedEvent(widget.trickModel.id, 1),
                    );
                  }
                });
              }
              return ShareManager.getBlockedUser()
                  ? Container(
                      height: 80,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 3,
                          )
                        ],
                      ),
                      child: const Text(
                        'شما مسدود شدید نمیتوانین نظر قرار دهید',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ValueListenableBuilder(
                      valueListenable: _editValueNotivier,
                      builder: (context, value, child) => SafeArea(
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _commendController,
                            onSubmitted: (value) {
                              if (ShareManager.getGust()) {
                                CustomSnakBar.getCustomSnakBar(
                                  'برای ثبت نظر باید ثبت نام کنید',
                                  context,
                                );
                                return;
                              }
                              if (!ShareManager.getVerifUser()) {
                                CustomSnakBar.getCustomSnakBar(
                                    'برای ثبت نظر باید ایمیل خود را وریفای کنین',
                                    context);
                                return;
                              }
                              if (_commendController.text.trim().isEmpty) {
                                CustomSnakBar.getCustomSnakBar(
                                  'نظر شما خالی است !',
                                  context,
                                );
                                return;
                              }
                              if (_isEdit) {
                                _isEdit = false;
                                BlocProvider.of<TrickBloc>(context).add(
                                  TrickUpdateEvent(
                                    commend: value.trim(),
                                    commendId: _commendId,
                                    trickId: widget.trickModel.id,
                                  ),
                                );
                                _commendId = '';
                              } else {
                                BlocProvider.of<TrickBloc>(context).add(
                                  TrickSendCommendEvent(
                                    value.trim(),
                                    widget.trickModel.id,
                                  ),
                                );
                              }
                              _commendController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                              suffixIcon: state is TrickLoadingCommendState
                                  ? LoadingAnimationWidget.fallingDot(
                                      color:
                                          GenerallColor.appBarBackGroundColor,
                                      size: 16)
                                  : IconButton(
                                      onPressed: () {
                                        if (ShareManager.getGust()) {
                                          CustomSnakBar.getCustomSnakBar(
                                            'برای ثبت نظر باید ثبت نام کنید',
                                            context,
                                          );
                                          return;
                                        }
                                        if (!ShareManager.getVerifUser()) {
                                          CustomSnakBar.getCustomSnakBar(
                                              'برای ثبت نظر باید ایمیل خود را وریفای کنین',
                                              context);
                                          return;
                                        }
                                        if (_commendController.text
                                            .trim()
                                            .isEmpty) {
                                          CustomSnakBar.getCustomSnakBar(
                                            'نظر شما خالی است !',
                                            context,
                                          );
                                          return;
                                        }
                                        if (_isEdit) {
                                          _isEdit = false;
                                          BlocProvider.of<TrickBloc>(context)
                                              .add(
                                            TrickUpdateEvent(
                                              commend: _commendController.text
                                                  .trim(),
                                              commendId: _commendId,
                                              trickId: widget.trickModel.id,
                                            ),
                                          );
                                          _commendId = '';
                                        } else {
                                          BlocProvider.of<TrickBloc>(context)
                                              .add(
                                            TrickSendCommendEvent(
                                              _commendController.text.trim(),
                                              widget.trickModel.id,
                                            ),
                                          );
                                        }
                                        _commendController.clear();
                                        FocusScope.of(context).unfocus();
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.arrow_uturn_left,
                                      ),
                                    ),
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
                    );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}

Widget deletIconStatus(context, TrickModel trickModel,
    TrickCommendModel trickCommendModel, int page, ValueNotifier deleteNotif) {
  // if (state is TrickLaodingDeleteState) {
  //   LoadingAnimationWidget.fourRotatingDots(
  //     color: GenerallColor.appBarBackGroundColor,
  //     size: 12,
  //   );
  // }
  // if (state is TrickResponseDeleteState) {
  //   state.responseDelete.fold((l) {
  //     return CustomSnakBar.getCustomSnakBar(l, context);
  //   }, (r) {
  //     if (r) {
  //       BlocProvider.of<TrickBloc>(context)
  //           .add(TrickRequestCommedEvent(trickModel.id, 1));
  //     }
  //   });
  // }
  return IconButton(
    onPressed: () {
      showDialog(
        useSafeArea: true,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          //TODO I have to Fix here
          return BlocProvider(
            create: (context) => TrickBloc(),
            child: BlocConsumer<TrickBloc, TrickState>(
              listener: (context, state) {},
              builder: (context, state) {
                return _CustomDialog(
                  trickCommendModel: trickCommendModel,
                  deleteNotif: deleteNotif,
                );
              },
            ),
          );
        },
      );
    },
    icon: const Icon(
      CupertinoIcons.delete,
      color: Colors.red,
    ),
  );
}

class _CustomDialog extends StatelessWidget {
  _CustomDialog(
      {super.key, required this.trickCommendModel, required this.deleteNotif});
  TrickCommendModel trickCommendModel;
  ValueNotifier deleteNotif;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: GenerallColor.primaryColor,
      shadowColor: GenerallColor.primaryColor,
      surfaceTintColor: Colors.white,
      elevation: 10,
      scrollable: false,
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'آيا مطمئن هستین که میخواهید این نظر را پاک کنین ؟',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: const Text(
        'پاک کردن نظر',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(70, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: GenerallColor.appBarBackGroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'خیر',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'vazirm',
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(70, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: GenerallColor.appBarBackGroundColor),
          onPressed: () {
            BlocProvider.of<TrickBloc>(context).add(
              TrickDeleteEvent(trickCommendModel.id),
            );
            CustomSnakBar.getCustomSnakBar('نظر شما با موفقیت حذف شد', context);
            deleteNotif.value = true;
            deleteNotif.notifyListeners();
            // BlocProvider.of<TrickBloc>(context).add(TrickRequestCommedEvent(trickModel.id));
            Navigator.pop(context);
          },
          child: const Text(
            'بله',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'vazirm',
            ),
          ),
        ),
      ],
    );
  }
}
