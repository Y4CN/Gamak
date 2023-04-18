import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/categoryBloc/categoryEvent.dart';
import 'package:game_hacks_chat/bloc/categoryBloc/categoryState.dart';
import 'package:game_hacks_chat/data/repository/categoryRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository = locator.get();
  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryRequestEvent>((event, emit) async {
      emit(CategoryLoadingState());
      var gameCat = await _categoryRepository.getCategoryGame(event.catId);
      emit(CategoryResponseState(gameCat));
    });
  }
}
