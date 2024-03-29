import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/categoryBloc/categoryBloc.dart';
import 'package:game_hacks_chat/bloc/categoryBloc/categoryEvent.dart';
import 'package:game_hacks_chat/bloc/categoryBloc/categoryState.dart';
import 'package:game_hacks_chat/constant/generallColor.dart';
import 'package:game_hacks_chat/data/model/categoryModel.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/widget/singleItem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryGameScreen extends StatefulWidget {
  CategoryGameScreen({super.key, required this.categoryModel});
  CategoryModel categoryModel;
  @override
  State<CategoryGameScreen> createState() => _CategoryGameScreenState();
}

class _CategoryGameScreenState extends State<CategoryGameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CategoryBloc>(context)
        .add(CategoryRequestEvent(widget.categoryModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
              widget.categoryModel.title,
              style: const TextStyle(fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryErrorState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
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
                          BlocProvider.of<CategoryBloc>(context).add(
                              CategoryRequestEvent(widget.categoryModel.id));
                        },
                        child: const Text(
                          'تلاش مجدد',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Text(state.errorText)
                  ],
                );
              }
              if (state is CategoryLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.fallingDot(
                      color: GenerallColor.appBarBackGroundColor, size: 30),
                );
              }
              if (state is CategoryResponseState) {
                return state.gameCat.fold((l) {
                  return Center(
                    child: Text(l,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'vazirm')),
                  );
                }, (r) {
                  if (r.isEmpty) {
                    return const Center(
                      child: Text(
                        '! متاسفانه درحال حاضر این بخش خالی است ',
                        style: TextStyle(fontSize: 20, fontFamily: 'vazirm'),
                      ),
                    );
                  }
                  return SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: r.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: singleItemGame(gameProductModel: r[index]),
                            );
                          },
                        )),
                  );
                });
              }
              return Container();
            },
          ),
        ));
  }
}
