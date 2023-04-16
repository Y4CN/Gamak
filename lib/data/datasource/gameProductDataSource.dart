import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/locator.dart';

import '../../utilities/errorHandler.dart';

abstract class IGameProductDataSource {
  Future<List<GameProductModel>> getAllgames();
}

class GameProductDataSource extends IGameProductDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<GameProductModel>> getAllgames() async {
    try {
      Map<String, dynamic> qExpanded = {
        'expand': 'category_id',
        'sort': '-updated'
      };
      var response = await _dio.get(
        'collections/games_product/records',
        queryParameters: qExpanded,
      );
      return response.data['items']
          .map<GameProductModel>((e) => GameProductModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}
