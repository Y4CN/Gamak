class HomeEvent {}

class HomeRequestEvent extends HomeEvent {
  int page;
  HomeRequestEvent({this.page = 1});
}
