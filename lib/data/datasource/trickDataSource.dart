import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/clientTrickModel.dart';
import 'package:game_hacks_chat/data/model/trickCommendModel.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';

abstract class ITrickDataSource {
  Future<List<TrickModel>> getTrickGame(String gameId);
  Future<bool> addTrick(
      String title, String description, List<File> images, String gameID);
  Future<List<TrickCommendModel>> getTrickCommed(String trickId);
  Future<bool> postTrickCommemd(String trickId, String commend);
  Future<bool> deleteTrickCommemd(String commendId);
  Future<bool> updateTrickcommend(
      String commendId, String commend, String trickId);

  Future<List<ClientTrickModel>> getAllTrickUser();
}

class TrickDataSource extends ITrickDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<TrickModel>> getTrickGame(String gameId) async {
    try {
      Map<String, dynamic> qpar = {
        'filter': '(game_id="$gameId" && status="good")',
        'expand': 'author_id',
      };
      var response = await _dio.get(
        'collections/trick_games/records',
        queryParameters: qpar,
      );
      return response.data['items']
          .map<TrickModel>((e) => TrickModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<List<TrickCommendModel>> getTrickCommed(String trickId) async {
    try {
      Map<String, dynamic> qpar = {
        'filter': 'trick_id="$trickId"',
        'expand': 'user_id',
        'sort': '-created',
      };
      var response = await _dio.get(
        'collections/trick_commend/records',
        queryParameters: qpar,
      );
      return response.data['items']
          .map<TrickCommendModel>((e) => TrickCommendModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<bool> postTrickCommemd(String trickId, String commend) async {
    try {
      Map<String, dynamic> qpar = {
        'expand': 'user_id',
      };
      await _dio.post(
        'collections/trick_commend/records',
        data: {
          'commend': commend,
          'trick_id': trickId,
          'user_id': ShareManager.readUserId()
        },
        queryParameters: qpar,
      );
      return true;
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<bool> deleteTrickCommemd(String commendId) async {
    try {
      await _dio.delete(
        'collections/trick_commend/records/$commendId',
      );
      return true;
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<bool> updateTrickcommend(
      String commendId, String commend, String trickId) async {
    try {
      Map<String, dynamic> qpar = {
        'expand': 'user_id',
      };
      await _dio.patch(
        'collections/trick_commend/records/$commendId',
        data: {
          'commend': commend,
          'trick_id': trickId,
          'user_id': ShareManager.readUserId()
        },
        queryParameters: qpar,
      );
      return true;
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<bool> addTrick(String title, String description, List<File> images,
      String gameID) async {
    try {
      FormData _formData = FormData.fromMap({
        'author_id': ShareManager.readUserId(),
        'game_id': gameID,
        'status': 'checking',
        'description': description,
        'title': title,
      });

      for (var element in images) {
        _formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(element.path),
          ),
        );
      }

      await _dio.post(
        'collections/trick_games/records',
        data: _formData,
      );
      return true;
    } on DioError catch (ex) {
      print(ex);
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<List<ClientTrickModel>> getAllTrickUser() async {
    try {
      Map<String, dynamic> qpar = {
        'filter': 'author_id="${ShareManager.readUserId()}"',
      };
      var response = await _dio.get(
        'collections/trick_games/records',
        queryParameters: qpar,
      );
      return response.data['items']
          .map<TrickModel>((e) => TrickModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}
