import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/mainBloc/mainBloc.dart';
import 'package:game_hacks_chat/bloc/mainBloc/mainEvent.dart';
import 'package:game_hacks_chat/bloc/mainBloc/mainState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/screens/homeScreen.dart';
import 'package:game_hacks_chat/screens/profileScreen.dart';
import 'package:game_hacks_chat/screens/searchScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainChagedScreenState) {
            return Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                    child: IndexedStack(
                      index: state.selectedPage,
                      children: const [
                        HomeScreen(),
                        SearchScreen(),
                        ProfileScreen()
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 30,
                    left: 30,
                    child: SafeArea(
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            width: double.infinity,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<MainBloc>(context)
                                        .add(MainChangeScreenEvent(value: 0));
                                  },
                                  child: SizedBox(
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          state.selectedPage == 0
                                              ? Icons.home
                                              : Icons.home_outlined,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Visibility(
                                          visible: state.selectedPage != 0,
                                          child: const Text(
                                            'Home',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<MainBloc>(context)
                                        .add(MainChangeScreenEvent(value: 1));
                                  },
                                  child: SizedBox(
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          state.selectedPage == 1
                                              ? CupertinoIcons
                                                  .search_circle_fill
                                              : CupertinoIcons.search_circle,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Visibility(
                                          visible: state.selectedPage != 1,
                                          child: const Text(
                                            'Search',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<MainBloc>(context)
                                        .add(MainChangeScreenEvent(value: 2));
                                  },
                                  child: SizedBox(
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          state.selectedPage == 2
                                              ? CupertinoIcons.person_fill
                                              : CupertinoIcons.person,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Visibility(
                                          visible: state.selectedPage != 2,
                                          child: const Text(
                                            'Profile',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
