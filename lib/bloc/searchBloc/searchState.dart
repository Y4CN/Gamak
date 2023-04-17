import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';

class SearchState {}



class SearchInitState extends SearchState{}


class SearchLoadingState extends SearchState{}
class SearchResponseState extends SearchState{
  Either<String,List<GameProductModel>> getSearchResult;
  SearchResponseState(this.getSearchResult);
}