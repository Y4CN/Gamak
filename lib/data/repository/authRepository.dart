import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/authDataSourca.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class IAuthRepository {
  Future<Either<String, bool>> register(
    String email,
    String userName,
    String name,
    String password,
    String passwordConfirm,
    File avatar,
  );
  Future<Either<String, bool>> login(
    String emailOruserName,
    String password,
  );
}

class AuthRepository extends IAuthRepository {
  final IAuthDataSource _authDataSource = locator.get();
  @override
  Future<Either<String, bool>> login(
      String emailOruserName, String password) async {
    try {
      await _authDataSource.login(emailOruserName, password);
      return const Right(true);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, bool>> register(String email, String userName,
      String name, String password, String passwordConfirm, File avatar) async {
    try {
      await _authDataSource.register(
        email,
        userName,
        name,
        password,
        passwordConfirm,
        avatar,
      );
      return const Right(true);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
}
