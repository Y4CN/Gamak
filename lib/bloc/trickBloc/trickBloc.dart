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
      var trickLst = await _trickRepository.getTrickGame(event.gameId,event.page);
      emit(TrickResponseState(trickLst));
    });

    on<TrickRequestCommedEvent>((event, emit) async {
      emit(TrickLoadingSingleState());
      var trickCommends = await _trickRepository.getTrickCommed(event.page,event.trickId);
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

    on<TrickUpdateEvent>((event, emit) async {
      emit(TrickUpdateLoadingState());
      var updateResponse = await _trickRepository.updateTrickcommend(
          event.commendId, event.commend, event.trickId);
      emit(TrickUpdateResponseState(updateResponse));
    });

    on<TrickAddTrickEvent>((event, emit) async {
      emit(TrickLoadingAddTrickState());
      var addTrick = await _trickRepository.addTrick(event.title, event.description, event.images, event.gameId);
      emit(TrcikResponseAddTrickState(addTrick));
    });
    


    on<TrickGetTrickUser>((event, emit) async {
      emit(TrickGetTrickUserLoadingState());
      var trickUser = await _trickRepository.getAllTrickUser(); 
      emit(TrickGetTriclResponseState(trickUser));
    });
  }
}
