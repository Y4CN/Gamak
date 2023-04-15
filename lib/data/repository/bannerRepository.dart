import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/bannet_dataSource.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerModel>>> getAllBanner();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource _bannerDataSource = locator.get();
  @override
  Future<Either<String, List<BannerModel>>> getAllBanner() async {
    try {
      var response = await _bannerDataSource.getAllBanner();
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
}
