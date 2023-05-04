import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeEvent.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeState.dart';
import 'package:game_hacks_chat/data/model/userModel.dart';
import 'package:game_hacks_chat/data/repository/authRepository.dart';
import 'package:game_hacks_chat/data/repository/bannerRepository.dart';
import 'package:game_hacks_chat/data/repository/categoryRepository.dart';
import 'package:game_hacks_chat/data/repository/gameProductRepository.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ICategoryRepository _categoryRepository = locator.get();
  final IAuthRepository _authRepository = locator.get();
  final IBannerRepository _bannerRepository = locator.get();
  final IGameProductRepository _gameProductRepository = locator.get();
  var userResponse ;
  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestEvent>((event, emit) async {
      emit(HomeLoadingState());
      var getAllCategory = await _categoryRepository.getAllCategory();
      if (ShareManager.getGust()) {
        Either<String,UserModel> gust(){
          return Right(UserModel(avatar: '', id: '', name: '', username: '', verified: false, isBlocked: false,),);
        }
        userResponse = gust();
      }else{
         userResponse = await _authRepository.readUser();
      }
      var readBanner = await _bannerRepository.getAllBanner();
      var games = await _gameProductRepository.getAllgameProduct();
      var popularGames = await _gameProductRepository.getPopulargameProduct();
      var newsGames = await _gameProductRepository.getNewGameProduct();
      emit(HomeResponseState(getAllCategory, userResponse, readBanner, games,
          popularGames, newsGames));
    });
  }
}
