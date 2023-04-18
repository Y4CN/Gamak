


import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/bannerDetalsModel.dart';

class BannerDetailsState{}


class BannerDetailsInitState extends BannerDetailsState{}
class BannerDetailsLoadingState extends BannerDetailsState{}
class BannerDetailsresponseState extends BannerDetailsState{
  Either<String,List<BannerDetailsModel>> bannerDetails;
  BannerDetailsresponseState(this.bannerDetails);
}