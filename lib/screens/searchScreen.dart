import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/searchBloc/searchBloc.dart';
import 'package:game_hacks_chat/bloc/searchBloc/searchEvent.dart';
import 'package:game_hacks_chat/bloc/searchBloc/searchState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/widget/singleItem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _saerchController;
  @override
  void initState() {
    super.initState();
    _saerchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 100,
              centerTitle: true,
              backgroundColor: GenerallColor.primaryColor,
              title: TextField(
                controller: _saerchController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  BlocProvider.of<SearchBloc>(context).add(
                    SearchRequestEvent(value),
                  );
                  _saerchController.clear();
                },
                decoration: InputDecoration(
                  // suffixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     CupertinoIcons.mic_fill,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // prefixIcon: const Icon(
                  //   CupertinoIcons.search,
                  //   color: Colors.black,
                  // ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      BlocProvider.of<SearchBloc>(context).add(
                        SearchRequestEvent(_saerchController.text.trim()),
                      );
                      _saerchController.clear();
                    },
                    icon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    ),
                  ),
                  hintText: '🎮 جست و جوی بازی مورد نظر 🎮',
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'لطفا بازی مورد نظر را جست و جو کنید',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'vazirm',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }
                if (state is SearchLoadingState) {
                  return SliverToBoxAdapter(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: GenerallColor.appBarBackGroundColor,
                      size: 26,
                    ),
                  );
                }
                if (state is SearchResponseState) {
                  return state.getSearchResult.fold((l) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          l,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'vazirm',
                          ),
                        ),
                      ),
                    );
                  }, (r) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 10,
                            ),
                            child: singleItemGame(
                              gameProductModel: r[index],
                            ));
                      }, childCount: r.length),
                    );
                  });
                }
                return Container();
              },
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 140),
            ),
          ],
        ),
      ),
    );
  }
}
