import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickBloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/clientTrickModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ClientTrickScreen extends StatefulWidget {
  const ClientTrickScreen({super.key});

  @override
  State<ClientTrickScreen> createState() => _ClientTrickScreenState();
}

class _ClientTrickScreenState extends State<ClientTrickScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SliverAppBar(
                    backgroundColor: GenerallColor.appBarBackGroundColor,
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
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
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              'ترفند های شما',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'vazirm',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: TabBarViewDelegate(
                    const TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.black,
                      indicatorPadding: EdgeInsets.only(bottom: 4),
                      // indicatorWeight: 2,
                      indicatorColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'vazirm',
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            'در حال بررسی',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'رد شده',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'قبول شده',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: BlocBuilder<TrickBloc, TrickState>(
              builder: (context, state) {
                if (state is TrickGetTrickUserLoadingState) {
                  return Center(
                    child: LoadingAnimationWidget.fallingDot(
                        color: GenerallColor.appBarBackGroundColor, size: 30),
                  );
                }
                if (state is TrickGetTriclResponseState) {
                  return state.trickUser.fold((l) {
                    return Center(
                      child: Text(
                        l,
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'vazirm'),
                      ),
                    );
                  }, (r) {
                    return TabBarView(
                      children: [
                        r
                                .where(
                                    (element) => element.status == 'checking')
                                .isEmpty
                            ? const Center(
                                child: Text(
                                  'خالی است !',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'vazirm',
                                  ),
                                ),
                              )
                            : _UnChechedTrick(
                                clientTrickModel: r
                                    .where((element) =>
                                        element.status == 'checking')
                                    .toList(),
                              ),
                        r.where((element) => element.status == 'bad').isEmpty
                            ? const Center(
                                child: Text(
                                  'خالی است !',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'vazirm',
                                  ),
                                ),
                              )
                            : _BadTrick(
                                clientTrickModel: r
                                    .where((element) => element.status == 'bad')
                                    .toList()),
                        r.where((element) => element.status == 'good').isEmpty
                            ? const Center(
                                child: Text(
                                  'خالی است !',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'vazirm',
                                  ),
                                ),
                              )
                            : _GoodTrick(
                                clientTrickModel: r
                                    .where(
                                        (element) => element.status == 'good')
                                    .toList(),
                              ),
                      ],
                    );
                  });
                }
                return const Text('خارج از سیستم');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TabBarViewDelegate extends SliverPersistentHeaderDelegate {
  TabBarViewDelegate(this._tabBar);

  final TabBar _tabBar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: GenerallColor.appBarBackGroundColor,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _UnChechedTrick extends StatelessWidget {
  _UnChechedTrick({super.key, required this.clientTrickModel});
  List<ClientTrickModel> clientTrickModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clientTrickModel.length,
      itemBuilder: (context, index) {
        return _singleShowTrickWidget(
          clientTrickModel: clientTrickModel[index],
        );
      },
    );
  }
}

class _BadTrick extends StatelessWidget {
  _BadTrick({super.key, required this.clientTrickModel});
  List<ClientTrickModel> clientTrickModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clientTrickModel.length,
      itemBuilder: (context, index) {
        return _singleShowTrickWidget(
          clientTrickModel: clientTrickModel[index],
        );
      },
    );
  }
}

class _GoodTrick extends StatelessWidget {
  _GoodTrick({super.key, required this.clientTrickModel});
  List<ClientTrickModel> clientTrickModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clientTrickModel.length,
      itemBuilder: (context, index) {
        return _singleShowTrickWidget(
          clientTrickModel: clientTrickModel[index],
        );
      },
    );
  }
}

class _singleShowTrickWidget extends StatelessWidget {
  _singleShowTrickWidget({super.key, required this.clientTrickModel});
  ClientTrickModel clientTrickModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: .3),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 12,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clientTrickModel.title,
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: double.infinity,
            height: 160,
            child: PageView.builder(
              controller: PageController(viewportFraction: .8),
              itemCount: clientTrickModel.images.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: clientTrickModel.images[index],
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: double.infinity,
                      width: 30,
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
                          horizontal: 10, vertical: 10),
                      height: double.infinity,
                      width: 30,
                      child: const Text(
                        'خطا در بارگذاری عکس',
                        style: TextStyle(fontFamily: 'vazirm'),
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
                          horizontal: 10, vertical: 10),
                      height: double.infinity,
                      width: 30,
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: GenerallColor.appBarBackGroundColor,
                        size: 30,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Text(
              clientTrickModel.description,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
