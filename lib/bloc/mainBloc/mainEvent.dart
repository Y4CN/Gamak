class MainEvent {}

class MainChangeScreenEvent extends MainEvent {
  int value;
  MainChangeScreenEvent({this.value = 0});
}
