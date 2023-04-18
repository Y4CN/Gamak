

class GameDetailsEvent{}


class GameDetailsRequestEvent extends GameDetailsEvent{
  String gameeId;
  GameDetailsRequestEvent(this.gameeId);
}