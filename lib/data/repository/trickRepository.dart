import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/trickDataSource.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class ITrickRepository{
  Future<Either<String,TrickModel>> getTrickGame(String gameId);
}



class TrickRepository extends ITrickRepository{
  final ITrickDataSource _dataSource = locator.get();
  @override
  Future<Either<String, TrickModel>> getTrickGame(String gameId) async{
    try {
      var response = await _dataSource.getTrickGame(gameId);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
 }