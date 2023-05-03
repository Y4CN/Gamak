class PassEvent{}



class PassChangeEvent extends PassEvent{
  bool show;
  PassChangeEvent(this.show);
}