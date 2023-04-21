
class TrickEvent{}


class TrickRequestEvent extends TrickEvent{
  String gameId;
  TrickRequestEvent(this.gameId);
}