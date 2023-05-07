import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/gameProductDataSource.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/locator.dart';

import '../../utilities/errorHandler.dart';

abstract class IGameProductRepository {
  Future<Either<String, List<GameProductModel>>> getAllgameProduct(int page);
  Future<Either<String, List<GameProductModel>>> getNewGameProduct(int page);
  Future<Either<String, List<GameProductModel>>> getPopulargameProduct();
  Future<Either<String, List<GameProductModel>>> getSearhGames(String txt);
}

class GameProductRepository extends IGameProductRepository {
  final IGameProductDataSource _gameProductDataSource = locator.get();
  @override
  Future<Either<String, List<GameProductModel>>> getAllgameProduct(int page) async {
    try {
      var response = await _gameProductDataSource.getUpdategames(page);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<GameProductModel>>> getPopulargameProduct() async {
    try {
      var response = await _gameProductDataSource.getPopulargames();
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<GameProductModel>>> getSearhGames(
      String txt) async {
    try {
      var response = await _gameProductDataSource.getSearhGames(txt);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<GameProductModel>>> getNewGameProduct(int page) async {
    try {
      var response = await _gameProductDataSource.getNewGames(page);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
}
