import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/datasource/authDataSourca.dart';
import 'package:game_hacks_chat/data/datasource/banner_dataSource.dart';
import 'package:game_hacks_chat/data/datasource/categoryDataSource.dart';
import 'package:game_hacks_chat/data/datasource/gameProductDataSource.dart';
import 'package:game_hacks_chat/data/repository/authRepository.dart';
import 'package:game_hacks_chat/data/repository/bannerRepository.dart';
import 'package:game_hacks_chat/data/repository/categoryRepository.dart';
import 'package:game_hacks_chat/data/repository/gameProductRepository.dart';
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
  locator.registerSingleton<IAuthDataSource>(AuthDataSource());
  locator.registerSingleton<IBannerDataSource>(BannerDataSource());
  locator.registerSingleton<IGameProductDataSource>(GameProductDataSource());

  //repository
  locator.registerSingleton<ICategoryRepository>(CategoryRepository());
  locator.registerSingleton<IAuthRepository>(AuthRepository());
  locator.registerSingleton<IBannerRepository>(BannerRepository());
  locator.registerSingleton<IGameProductRepository>(GameProductRepository());
}
