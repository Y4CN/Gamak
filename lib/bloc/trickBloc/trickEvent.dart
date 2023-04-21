
class TrickEvent{}


class TrickRequestEvent extends TrickEvent{
  String gameId;
  TrickRequestEvent(this.gameId);
}



class TrickRequestCommedEvent extends TrickEvent{
  String trickId;
  TrickRequestCommedEvent(this.trickId);
}



class TrickSendCommendEvent extends TrickEvent{
  String trickId;
  String commned;
  TrickSendCommendEvent(this.commned,this.trickId);
}


class TrickDeleteEvent extends TrickEvent{
  String commnedId;
  TrickDeleteEvent(this.commnedId);
}