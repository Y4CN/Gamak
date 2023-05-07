import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeBloc.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeEvent.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/widget/singleItem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListGameScreen extends StatefulWidget {
  ListGameScreen({super.key, required this.title});
  String title;
  @override
  State<ListGameScreen> createState() => _ListGameScreenState();
}

class _ListGameScreenState extends State<ListGameScreen> {
  late int _page;
  @override
  void initState() {
    super.initState();
    _page = 1;
    BlocProvider.of<HomeBloc>(context).add(HomeRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.forward,
              size: 26,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        surfaceTintColor: GenerallColor.primaryColor,
        backgroundColor: GenerallColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: GenerallColor.appBarBackGroundColor,
                size: 30,
              ),
            );
          }
          if (state is HomeResponseState && widget.title == 'بازی های جدید') {
            return state.newGames.fold((l) {
              return Center(
                child: Text(
                  l,
                  style: const TextStyle(fontSize: 18, fontFamily: 'vazirm'),
                ),
              );
            }, (r) {
              return ListView.builder(
                itemCount: r.length >= 30 ? r.length + 1 : r.length,
                itemBuilder: (context, index) {
                  if (index == 30) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 20,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: GenerallColor.appBarBackGroundColor
                              .withOpacity(.8),
                        ),
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(HomeRequestEvent(page: ++_page));
                        },
                        child: const Text(
                          'بیشتر',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: singleItemGame(gameProductModel: r[index]),
                  );
                },
              );
            });
          }
          if (state is HomeResponseState &&
              widget.title == 'بازی های آپدیت شده') {
            return state.games.fold((l) {
              return Center(
                child: Text(
                  l,
                  style: const TextStyle(fontSize: 18, fontFamily: 'vazirm'),
                ),
              );
            }, (r) {
              return ListView.builder(
                itemCount: r.length >= 30 ? r.length + 1 : r.length,
                itemBuilder: (context, index) {
                  if (index == 30) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: GenerallColor.appBarBackGroundColor
                              .withOpacity(.8),
                        ),
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(HomeRequestEvent(page: ++_page));
                        },
                        child: const Text(
                          'بیشتر',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: singleItemGame(gameProductModel: r[index]),
                  );
                },
              );
            });
          }
          return Text('Out of ranage');
        },
      ),
    );
  }
}
