import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/descriptionModel.dart';
import 'package:game_hacks_chat/data/model/imageGameModel.dart';

class GameDetailsState {}

class GameDetailsInitState extends GameDetailsState {}

class GameDetailsLoadingState extends GameDetailsState {}

class GameDetailsResponseState extends GameDetailsState {
  Either<String, DescriptionModel> decription;
  Either<String, List<ImageGameModel>> images;
  GameDetailsResponseState(this.decription,this.images);
}
