import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class ITrickDataSource {
  Future<TrickModel> getTrickGame(String gameId);
}

class TrickDataSource extends ITrickDataSource {
  final Dio _dio = locator.get();
  @override
  Future<TrickModel> getTrickGame(String gameId) async {
    try {
      Map<String, dynamic> qpar = {
        'filter': 'game_id="$gameId"',
        'expand': 'author_id',
      };
      var response = await _dio.get(
        'collections/trick_games/records',
        queryParameters: qpar,
      );
      print(response.data['items']);
      return TrickModel.fromJson(response.data['items']);
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}
