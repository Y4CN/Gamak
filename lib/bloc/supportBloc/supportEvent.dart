

class SupportEvent{}


class SupportSendEmailEvent extends SupportEvent{
  String title;
  String description;

  SupportSendEmailEvent(this.description,this.title);
}