
import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';

class TrickState{}


class TrickInitState extends TrickState{}
class TrickLoadingState extends TrickState{}
class TrickResponseState extends TrickState{
  Either<String,List<TrickModel>> trickLst;
  TrickResponseState(this.trickLst);
}