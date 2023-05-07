import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/descriptionModel.dart';
import 'package:game_hacks_chat/data/model/imageGameModel.dart';
import 'package:game_hacks_chat/data/model/platformModel.dart';

class GameDetailsState {}

class GameDetailsInitState extends GameDetailsState {}

class GameDetailsLoadingState extends GameDetailsState {}

class GameDetailsResponseState extends GameDetailsState {
  Either<String, DescriptionModel> decription;
  Either<String, List<ImageGameModel>> images;
  Either<String, List<PlatformModel>> platform;
  GameDetailsResponseState(
    this.decription,
    this.images,
    this.platform,
  );
}


class GameDetailsErrorState extends GameDetailsState{
  String errorText;
  GameDetailsErrorState(this.errorText);
}
