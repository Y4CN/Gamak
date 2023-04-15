import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeEvent.dart';
import 'package:game_hacks_chat/bloc/homeBloc/homeState.dart';
import 'package:game_hacks_chat/data/repository/authRepository.dart';
import 'package:game_hacks_chat/data/repository/categoryRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ICategoryRepository _categoryRepository = locator.get();
  final IAuthRepository _authRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestEvent>((event, emit) async {
      emit(HomeLoadingState());
      var getAllCategory = await _categoryRepository.getAllCategory();
      var userResponse = await _authRepository.readUser();
      emit(HomeResponseState(getAllCategory, userResponse));
    });
  }
}
