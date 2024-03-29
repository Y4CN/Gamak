import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/bannerDetalsModel.dart';
import 'package:game_hacks_chat/data/model/descriptionModel.dart';
import 'package:game_hacks_chat/data/model/imageGameModel.dart';
import 'package:game_hacks_chat/data/model/platformModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class IGameDetailsDataSource {
  Future<DescriptionModel> getDescription(String gameId);
  Future<List<ImageGameModel>> getImageGames(String gameID);
  Future<List<PlatformModel>> getPlatformGames(String gameID);
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
      if (response.data['items'].isEmpty) {
        return DescriptionModel(
          description: 'متاسفانه اکنون مطلبی برای اراثه نیست',
          gameId: gameId,
          id: '-1',
        );
      }
      return DescriptionModel.fromJson(response.data['items'][0]);
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<List<ImageGameModel>> getImageGames(String gameID) async {
    try {
      Map<String, dynamic> q = {
        'filter': 'game_id="$gameID"',
      };
      var response = await _dio.get(
        'collections/game_image/records',
        queryParameters: q,
      );
      return response.data['items']
          .map<ImageGameModel>((e) => ImageGameModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<List<PlatformModel>> getPlatformGames(String gameID) async {
    try {
      Map<String, dynamic> q = {
        'filter': 'game_id="$gameID"',
      };
      var response = await _dio.get(
        'collections/game_platform/records',
        queryParameters: q,
      );
      return response.data['items']
          .map<PlatformModel>((e) => PlatformModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}
