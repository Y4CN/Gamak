import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/datasource/trickDataSource.dart';
import 'package:game_hacks_chat/data/model/clientTrickModel.dart';
import 'package:game_hacks_chat/data/model/trickCommendModel.dart';
import 'package:game_hacks_chat/data/model/trickModel.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

abstract class ITrickRepository {
  Future<Either<String, List<TrickModel>>> getTrickGame(String gameId,int page);
  Future<Either<String, List<TrickCommendModel>>> getTrickCommed(
      int page, String trickId);
  Future<Either<String, bool>> addTrick(
      String title, String description, List<File> images, String gameID);
  Future<Either<String, bool>> postTrickCommemd(String trickId, String commend);
  Future<Either<String, bool>> deleteTrickCommemd(String commendId);
  Future<Either<String, bool>> updateTrickcommend(
      String commendId, String commend, String trickId);
  Future<Either<String, List<ClientTrickModel>>> getAllTrickUser();
}

class TrickRepository extends ITrickRepository {
  final ITrickDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<TrickModel>>> getTrickGame(String gameId,int page) async {
    try {
      var response = await _dataSource.getTrickGame(gameId,page);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<TrickCommendModel>>> getTrickCommed(
      int page, String trickId) async {
    try {
      var response = await _dataSource.getTrickCommed(trickId, page);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, bool>> postTrickCommemd(
      String trickId, String commend) async {
    try {
      var response = await _dataSource.postTrickCommemd(trickId, commend);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, bool>> deleteTrickCommemd(String commendId) async {
    try {
      var response = await _dataSource.deleteTrickCommemd(commendId);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, bool>> updateTrickcommend(
      String commendId, String commend, String trickId) async {
    try {
      var response =
          await _dataSource.updateTrickcommend(commendId, commend, trickId);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, bool>> addTrick(String title, String description,
      List<File> images, String gameID) async {
    try {
      var response =
          await _dataSource.addTrick(title, description, images, gameID);
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, List<ClientTrickModel>>> getAllTrickUser() async {
    try {
      var response = await _dataSource.getAllTrickUser();
      return Right(response);
    } on ErrorHandler catch (e) {
      throw Left(e.message ?? 'خطای ناشناخته');
    }
  }
}
