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
    try {
        var des = await _gameDetailsrepository.getDescription(event.gameeId);
      var image = await _gameDetailsrepository.getImageGame(event.gameeId);
      var platform =
          await _gameDetailsrepository.getPlatformGame(event.gameeId);
      emit(GameDetailsResponseState(des, image, platform));
    } catch (e) {
      emit(GameDetailsErrorState('مشکلی در گرفتن جزئیات بازی به وجود اومده'));
    }
    });
  }
}
