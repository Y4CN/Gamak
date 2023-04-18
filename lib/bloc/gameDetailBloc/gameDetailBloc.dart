import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/gameDetailBloc/gameDetailEvent.dart';
import 'package:game_hacks_chat/bloc/gameDetailBloc/gameDetailState.dart';
import 'package:game_hacks_chat/data/repository/gameDetailsRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  final IGameDetailsrepository _gameDetailsrepository = locator.get();
  GameDetailsBloc() : super(GameDetailsInitState()) {
    on<GameDetailsRequestEvent>((event, emit) async {
      emit(GameDetailsLoadingState());
      var des = await _gameDetailsrepository.getDescription(event.gameeId);
      var image = await _gameDetailsrepository.getImageGame(event.gameeId);
      emit(GameDetailsResponseState(des,image));
    });
  }
}
