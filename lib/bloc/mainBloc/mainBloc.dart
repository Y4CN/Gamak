import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/mainBloc/mainEvent.dart';
import 'package:game_hacks_chat/bloc/mainBloc/mainState.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainChagedScreenState(selectedPage: 0)) {
    on<MainChangeScreenEvent>((event, emit) {
      emit(MainChagedScreenState(selectedPage: event.value));
    });
  }
}
