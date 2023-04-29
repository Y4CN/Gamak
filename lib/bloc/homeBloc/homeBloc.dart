import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeEvent.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeState.dart';
import 'package:game_hacks_chat/data/repository/authRepository.dart';
import 'package:game_hacks_chat/data/repository/bannerRepository.dart';
import 'package:game_hacks_chat/data/repository/categoryRepository.dart';
import 'package:game_hacks_chat/data/repository/gameProductRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ICategoryRepository _categoryRepository = locator.get();
  final IAuthRepository _authRepository = locator.get();
  final IBannerRepository _bannerRepository = locator.get();
  final IGameProductRepository _gameProductRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestEvent>((event, emit) async {
      emit(HomeLoadingState());
      var getAllCategory = await _categoryRepository.getAllCategory();
      var userResponse = await _authRepository.readUser();
      var readBanner = await _bannerRepository.getAllBanner();
      var games = await _gameProductRepository.getAllgameProduct();
      var popularGames = await _gameProductRepository.getPopulargameProduct();
      var newsGames = await _gameProductRepository.getNewGameProduct();
      emit(HomeResponseState(getAllCategory, userResponse, readBanner, games,
          popularGames, newsGames));
    });
  }
}
