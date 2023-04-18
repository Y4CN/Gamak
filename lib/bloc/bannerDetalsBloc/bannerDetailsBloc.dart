import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/bannerDetalsBloc/bannerDetailsEvent.dart';
import 'package:game_hacks_chat/bloc/bannerDetalsBloc/bannerDetailsState.dart';
import 'package:game_hacks_chat/data/repository/bannerRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class BannerDetailsBloc extends Bloc<BannerDetailsEvent, BannerDetailsState> {
  final IBannerRepository _bannerRepository = locator.get();
  BannerDetailsBloc() : super(BannerDetailsInitState()) {
    on<BannerDetailsRequestEvent>((event, emit) async {
      emit(BannerDetailsLoadingState());
      var bannerItems =
          await _bannerRepository.getDetailsBanner(event.bannerId);
      emit(BannerDetailsresponseState(bannerItems));
    });
  }
}