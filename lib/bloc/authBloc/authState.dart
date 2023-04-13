import 'package:dartz/dartz.dart';

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
