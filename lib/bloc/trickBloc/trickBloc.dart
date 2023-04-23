import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickEvent.dart';
import 'package:game_hacks_chat/bloc/trickBloc/trickState.dart';
import 'package:game_hacks_chat/data/repository/trickRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class TrickBloc extends Bloc<TrickEvent, TrickState> {
  final ITrickRepository _trickRepository = locator.get();
  TrickBloc() : super(TrickInitState()) {
    on<TrickRequestEvent>((event, emit) async {
      emit(TrickLoadingState());
      var trickLst = await _trickRepository.getTrickGame(event.gameId);
      emit(TrickResponseState(trickLst));
    });

    on<TrickRequestCommedEvent>((event, emit) async {
      emit(TrickLoadingSingleState());
      var trickCommends = await _trickRepository.getTrickCommed(event.trickId);
      emit(TrickResponseSingleState(trickCommends));
    });

    on<TrickSendCommendEvent>((event, emit) async {
      emit(TrickLoadingCommendState());
      var response =
          await _trickRepository.postTrickCommemd(event.trickId, event.commned);
      emit(TrickResponseCommendState(response));
    });

    on<TrickDeleteEvent>((event, emit) async {
      emit(TrickLaodingDeleteState());
      var responseDelete =
          await _trickRepository.deleteTrickCommemd(event.commnedId);
      emit(TrickResponseDeleteState(responseDelete));
    });
  }
}
