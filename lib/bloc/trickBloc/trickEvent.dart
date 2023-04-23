class TrickEvent {}

class TrickRequestEvent extends TrickEvent {
  String gameId;
  TrickRequestEvent(this.gameId);
}

class TrickRequestCommedEvent extends TrickEvent {
  String trickId;
  TrickRequestCommedEvent(this.trickId);
}

class TrickSendCommendEvent extends TrickEvent {
  String trickId;
  String commned;
  TrickSendCommendEvent(this.commned, this.trickId);
}

class TrickDeleteEvent extends TrickEvent {
  String commnedId;
  TrickDeleteEvent(this.commnedId);
}

class TrickUpdateEvent extends TrickEvent {
  String commendId;
  String commend;
  String trickId;

  TrickUpdateEvent({
    required this.commend,
    required this.commendId,
    required this.trickId,
  });
}
