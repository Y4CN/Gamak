import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';

class CategoryState{}



class CategoryInitState extends CategoryState{}
class CategoryLoadingState extends CategoryState{}
class CategoryResponseState extends CategoryState{
  Either<String,List<GameProductModel>> gameCat;
  CategoryResponseState(this.gameCat);
}