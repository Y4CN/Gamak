class MainState{}


class MainInitState extends MainState{}

class MainChagedScreenState extends MainState{
  int selectedPage;
  MainChagedScreenState({required this.selectedPage});
}