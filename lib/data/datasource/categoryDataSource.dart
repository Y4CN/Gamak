import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_hacks_chat/data/model/categoryModel.dart';
import 'package:game_hacks_chat/data/model/gameProductModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/screens/homeScreen.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class ICategoryDatasource {
  Future<List<CategoryModel>> getAllCategory();
  Future<List<GameProductModel>> getCategoryGame(String gameId);
}

class CategoryDataSource extends ICategoryDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      var response = await _dio.get('collections/category_games/records');
      return response.data['items']
          .map<CategoryModel>((e) => CategoryModel.fromJson(e))
          .toList();
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<List<GameProductModel>> getCategoryGame(String gameId) async {
    try {
      Map<String, dynamic> q = {
        'filter': 'category_id="$gameId"',
        'expand': 'category_id',
        'sort': '-updated'
      };
      var response = await _dio.get(
        'collections/games_product/records',
        queryParameters: q,
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
