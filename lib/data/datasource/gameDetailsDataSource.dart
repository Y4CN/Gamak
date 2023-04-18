import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/bannerDetalsModel.dart';
import 'package:game_hacks_chat/data/model/descriptionModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class IGameDetailsDataSource {
  Future<DescriptionModel> getDescription(String gameId);
}

class GameDetailsDataSource extends IGameDetailsDataSource {
  final Dio _dio = locator.get();
  @override
  Future<DescriptionModel> getDescription(String gameId) async {
    try {
      Map<String, dynamic> q = {
        'filter': 'game_id="$gameId"',
      };
      var response = await _dio.get(
        'collections/game_details/records',
        queryParameters: q,
      );
      return DescriptionModel.fromJson(response.data['items'][0]);
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}
