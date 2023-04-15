import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/gameProductDataSource.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/locator.dart';

import '../../utilities/errorHandler.dart';

abstract class IGameProductRepository{
  Future<Either<String,List<GameProductModel>>> getAllgameProduct();
}


class GameProductRepository extends IGameProductRepository{
  final IGameProductDataSource _gameProductDataSource = locator.get();
  @override
  Future<Either<String, List<GameProductModel>>> getAllgameProduct() async{
  try {
      var response = await _gameProductDataSource.getAllgames();
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

}