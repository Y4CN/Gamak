import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/clientTrickModel.dart';
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



class TrickLaodingDeleteState extends TrickState{}
class TrickResponseDeleteState extends TrickState{
  Either<String,bool> responseDelete;
  TrickResponseDeleteState(this.responseDelete); 
}


class TrickUpdateLoadingState extends TrickState{

}


class TrickUpdateResponseState extends TrickState{
  Either<String,bool> updateResponse;
  TrickUpdateResponseState(this.updateResponse);
}



class TrickLoadingAddTrickState extends TrickState{
  
}


class TrcikResponseAddTrickState extends TrickState{
  Either<String , bool> addTrick;
  TrcikResponseAddTrickState(this.addTrick);
}


class TrickGetTrickUserLoadingState extends TrickState{}


class TrickGetTriclResponseState extends TrickState{
  Either<String,List<ClientTrickModel>> trickUser;
  TrickGetTriclResponseState(this.trickUser);
}


class TrickListErrorState extends TrickState{
  String errorText;
  TrickListErrorState(this.errorText);
} 