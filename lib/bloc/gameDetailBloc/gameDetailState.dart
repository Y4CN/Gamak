import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/descriptionModel.dart';

class GameDetailsState {}

class GameDetailsInitState extends GameDetailsState {}

class GameDetailsLoadingState extends GameDetailsState {}

class GameDetailsResponseState extends GameDetailsState {
  Either<String, DescriptionModel> decription;
  GameDetailsResponseState(this.decription);
}
