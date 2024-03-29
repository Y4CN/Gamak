import 'dart:io';

class TrickEvent {}

class TrickRequestEvent extends TrickEvent {
  String gameId;
  int page;
  TrickRequestEvent(this.gameId,this.page);
}

class TrickRequestCommedEvent extends TrickEvent {
  String trickId;
  int page;
  TrickRequestCommedEvent(this.trickId,this.page);
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


class TrickAddTrickEvent extends TrickEvent{
  String title;
  String description;
  String gameId;
  List<File> images;

  TrickAddTrickEvent(this.description,this.gameId,this.images,this.title);
}


class TrickGetTrickUser extends TrickEvent{}