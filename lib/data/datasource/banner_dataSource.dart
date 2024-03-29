import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/bannerDetalsModel.dart';
import 'package:game_hacks_chat/data/model/bannerModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class IBannerDataSource {
  Future<List<BannerModel>> getAllBanner();
  Future<List<BannerDetailsModel>> getDetailsAllBanner(String bannerId);
}

class BannerDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerModel>> getAllBanner() async {
    try {
      Map<String, dynamic> q = {'sort': '-updated'};
      var response = await _dio.get('collections/banner_games/records',
          queryParameters: q);
      return response.data['items']
          .map<BannerModel>((e) => BannerModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<List<BannerDetailsModel>> getDetailsAllBanner(String bannerId) async {
    try {
      Map<String, dynamic> q = {
        'filter': 'banner_id="$bannerId"',
        // 'filter': 'show="true"'
      };
      var response = await _dio.get(
        'collections/banner_details/records',
        queryParameters: q,
      );
      return response.data['items']
          .map<BannerDetailsModel>((e) => BannerDetailsModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}
