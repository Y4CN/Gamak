


import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:game_hacks_chat/data/model/categoryModel.dart';
import 'package:game_hacks_chat/data/model/userModel.dart';

class HomeState{}


class HomeInitState extends HomeState{}
class HomeLoadingState extends HomeState{}
class HomeResponseState extends HomeState{
  Either<String,List<CategoryModel>> getAllCategory;
  Either<String,UserModel> readUser;
  Either<String , List<BannerModel>> getAllBanner;
  HomeResponseState(this.getAllCategory,this.readUser,this.getAllBanner);
}