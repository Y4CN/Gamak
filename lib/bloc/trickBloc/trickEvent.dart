
class TrickEvent{}


class TrickRequestEvent extends TrickEvent{
  String gameId;
  TrickRequestEvent(this.gameId);
}



class TrickRequestCommedEvent extends TrickEvent{
  String trickId;
  TrickRequestCommedEvent(this.trickId);
}