import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_hacks_chat/data/model/userModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';
import 'package:game_hacks_chat/utilities/sharManager.dart';

abstract class IAuthDataSource {
  Future<void> register(
    String email,
    String userName,
    String name,
    String password,
    String passwordConfirm,
    File? avatar,
  );
  Future<void> login(
    String emailOruserName,
    String password,
  );

  Future<UserModel> readUser();
}

class AuthDataSource extends IAuthDataSource {
  final Dio _dio = locator.get();

  @override
  Future<void> login(String emailOruserName, String password) async {
    try {
      var response = await _dio.post(
        'collections/users/auth-with-password',
        data: {
          'identity': emailOruserName,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        ShareManager.saveToken(response.data['token']);
        ShareManager.saveUserId(response.data['record']['id']);
      }
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<void> register(
    String email,
    String userName,
    String name,
    String password,
    String passwordConfirm,
    File? avatar,
  ) async {
//        {
//           'username': userName,
//           'email': email,
//           'password': password,
//           'passwordConfirm': passwordConfirm,
//           'name': name,
//           'avatar': avatar
//         },

    FormData _formData = FormData.fromMap({
      'username': userName,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'name': name,
      'avatar':
          avatar == null ? null : await MultipartFile.fromFile(avatar.path)
    });
    try {
      await _dio.post('collections/users/records', data: _formData);
    } on DioError catch (ex) {
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }

  @override
  Future<UserModel> readUser() async {
    try {
      var id = ShareManager.readUserId();
      var response = await _dio.get(
        'collections/users/records/$id',
      );
      return UserModel.fromJson(response.data);
    } on DioError catch (ex) {
      print(ex.message);
      throw ErrorHandler(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ErrorHandler(0, 'unknown erorr');
    }
  }
}