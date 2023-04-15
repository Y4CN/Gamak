import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class IBannerDataSource {
  Future<List<BannerModel>> getAllBanner();
}

class BannerDataSource extends IBannerDataSource {
  @override
  Future<List<BannerModel>> getAllBanner() async {
    final Dio _dio = locator.get();
    try {
      var response = await _dio.get('collections/banner_games/records');
      return response.data['items']
          .map<BannerModel>((e) => BannerModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}
