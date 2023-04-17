


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/searchBloc/searchEvent.dart';
import 'package:game_hacks_chat/bloc/searchBloc/searchState.dart';
import 'package:game_hacks_chat/data/repository/gameProductRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  final IGameProductRepository _gameProductRepository = locator.get();
  SearchBloc():super(SearchInitState()){
    on<SearchRequestEvent>((event, emit) async {
      emit(SearchLoadingState());
      var searchResult = await _gameProductRepository.getSearhGames(event.txt);
      emit(SearchResponseState(searchResult));
    });
  }

}