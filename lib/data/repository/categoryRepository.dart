import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/categoryDataSource.dart';
import 'package:game_hacks_chat/data/model/categoryModel.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<CategoryModel>>> getAllCategory();
  Future<Either<String, List<GameProductModel>>> getCategoryGame(String catID);
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<CategoryModel>>> getAllCategory() async {
    try {
      var response = await _datasource.getAllCategory();
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
  
  @override
  Future<Either<String, List<GameProductModel>>> getCategoryGame(String catID) async{
     try {
      var response = await _datasource.getCategoryGame(catID);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
}
