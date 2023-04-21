import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/trickDataSource.dart';
import 'package:game_hacks_chat/data/model/trickCommendModel.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class ITrickRepository {
  Future<Either<String, List<TrickModel>>> getTrickGame(String gameId);
  Future<Either<String, List<TrickCommendModel>>> getTrickCommed(
      String trickId);
  Future<Either<String, bool>> postTrickCommemd(String trickId, String commend);
  Future<Either<String, bool>> deleteTrickCommemd(String commendId);
}

class TrickRepository extends ITrickRepository {
  final ITrickDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<TrickModel>>> getTrickGame(String gameId) async {
    try {
      var response = await _dataSource.getTrickGame(gameId);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<TrickCommendModel>>> getTrickCommed(
      String trickId) async {
    try {
      var response = await _dataSource.getTrickCommed(trickId);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, bool>> postTrickCommemd(
      String trickId, String commend) async {
    try {
      var response = await _dataSource.postTrickCommemd(trickId, commend);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
  
  @override
  Future<Either<String, bool>> deleteTrickCommemd(String commendId) async {
     try {
      var response = await _dataSource.deleteTrickCommemd(commendId);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
}
