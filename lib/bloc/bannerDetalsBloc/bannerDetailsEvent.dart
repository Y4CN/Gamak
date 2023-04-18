

class BannerDetailsEvent{}



class BannerDetailsRequestEvent extends BannerDetailsEvent{
  String bannerId;
  BannerDetailsRequestEvent(this.bannerId);
}