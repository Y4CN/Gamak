import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/trickCommendModel.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';

class TrickState {}

class TrickInitState extends TrickState {}

class TrickLoadingState extends TrickState {}

class TrickResponseState extends TrickState {
  Either<String, List<TrickModel>> trickLst;
  TrickResponseState(this.trickLst);
}

class TrickLoadingSingleState extends TrickState {}

class TrickResponseSingleState extends TrickState {
  Either<String, List<TrickCommendModel>> trickCommends;
  TrickResponseSingleState(this.trickCommends);
}



class TrickLoadingCommendState extends TrickState{

}

class TrickResponseCommendState extends TrickState{
  Either<String,bool> trickCommend;
  TrickResponseCommendState(this.trickCommend);
}