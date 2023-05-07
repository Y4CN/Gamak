import 'package:dartz/dartz.dart';
import 'package:game_hacks_chat/data/model/userModel.dart';

class AuthState {}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginResponseState extends AuthState {
  Either<String, bool> login;
  AuthLoginResponseState(this.login);
}

class AuthRegisterResponseState extends AuthState {
  Either<String, bool> register;
  AuthRegisterResponseState(this.register);
}

class AuthReadUserResponseState extends AuthState {
  Either<String, UserModel> readUser;

  AuthReadUserResponseState(this.readUser);
}

class AuthVerifyResponseState extends AuthState {
  Either<String, bool> response;
  AuthVerifyResponseState(this.response);
}

class AuthForgotPassResponseState extends AuthState {
  Either<String, bool> response;
  AuthForgotPassResponseState(this.response);
}


class AuthEditUserDetailsResponseState extends AuthState{
  Either<String , bool> response;
  AuthEditUserDetailsResponseState(this.response);
}

class AuthRegisterErrorState extends AuthState{
  String errorText;
  AuthRegisterErrorState(this.errorText);
}

class AuthLoginErrorState extends AuthState{
  String errorText;
  AuthLoginErrorState(this.errorText);
}