import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/datasource/categoryDataSource.dart';
import 'package:game_hacks_chat/data/repository/categoryRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> initGet_it() async {
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8090/api/')));

  //dataSource
  locator.registerSingleton<ICategoryDatasource>(CategoryDataSource());

  //repository
  locator.registerSingleton<ICategoryRepository>(CategoryRepository());
}
