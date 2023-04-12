


import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/categoryModel.dart';

class HomeState{}


class HomeInitState extends HomeState{}
class HomeLoadingState extends HomeState{}
class HomeResponseState extends HomeState{
  Either<String,List<CategoryModel>> getAllCategory;
  HomeResponseState(this.getAllCategory);
}