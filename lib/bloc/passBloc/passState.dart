class PassState{}


class PassInitState extends PassState{}

class PassResponseState extends PassState{
  bool show;
  PassResponseState(this.show);
}