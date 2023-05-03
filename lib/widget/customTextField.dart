import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/passBloc/passEvent.dart';
import 'package:game_hacks_chat/bloc/passBloc/passState.dart';
import 'package:game_hacks_chat/bloc/passBloc/passbloc.dart';

class CustomTextFeild extends StatelessWidget {
  CustomTextFeild(
      {super.key,
      required this.controller,
      required this.txt,
      required this.isPassword});
  TextEditingController controller;
  String txt;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PassBloc()..add(PassChangeEvent(false)),
        child: BlocBuilder<PassBloc, PassState>(
          builder: (context, state) {
            if (state is PassResponseState) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 14,
                  right: 12,
                  left: 12,
                ),
                child: TextField(
                  obscureText:
                      !state.show ? (isPassword ? true : false) : false,
                  enableSuggestions: isPassword ? false : true,
                  autocorrect: isPassword ? false : true,
                  controller: controller,
                  decoration: InputDecoration(
                    suffixIcon: isPassword
                        ? IconButton(
                            onPressed: () {
                              if (state.show) {
                                BlocProvider.of<PassBloc>(context)
                                    .add(PassChangeEvent(false));
                              } else {
                                BlocProvider.of<PassBloc>(context)
                                    .add(PassChangeEvent(true));
                              }
                            },
                            icon: state.show
                                ? const Icon(CupertinoIcons.eye_fill)
                                : const Icon(CupertinoIcons.eye_slash_fill),
                          )
                        : null,
                    labelText: txt,
                    labelStyle: const TextStyle(fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(
                top: 14,
                right: 12,
                left: 12,
              ),
              child: TextField(
                obscureText: isPassword ? true : false,
                enableSuggestions: isPassword ? false : true,
                autocorrect: isPassword ? false : true,
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: isPassword
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.eye),
                        )
                      : null,
                  labelText: txt,
                  labelStyle: const TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
