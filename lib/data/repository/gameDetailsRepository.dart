import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/gameDetailsDataSource.dart';
import 'package:game_hacks_chat/data/model/descriptionModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class IGameDetailsrepository {
  Future<Either<String, DescriptionModel>> getDescription(String gameId);
}

class GameDetailsRepository extends IGameDetailsrepository {
  final IGameDetailsDataSource _gameDetailsDataSource = locator.get();
  @override
  Future<Either<String, DescriptionModel>> getDescription(String gameId) async {
    try {
      var response = await _gameDetailsDataSource.getDescription(gameId);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
}