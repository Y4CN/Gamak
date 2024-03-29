import 'dart:io';

class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  String emailOruserName;
  String passwrod;
  AuthLoginEvent(this.emailOruserName, this.passwrod);
}

class AuthRegisterEvent extends AuthEvent {
  String email;
  String userName;
  String name;
  String password;
  String passwordConfirm;
  File? avatar;

  AuthRegisterEvent(
    this.avatar,
    this.email,
    this.name,
    this.password,
    this.passwordConfirm,
    this.userName,
  );
}

class AuthReadUserEvent extends AuthEvent {}

class AuthVerifyEvent extends AuthEvent {
  String email;
  AuthVerifyEvent(this.email);
}

class AuthForgotPassEvent extends AuthEvent {
  String email;
  AuthForgotPassEvent(this.email);
}

class AuthChangeUserDetailsEvent extends AuthEvent {
  String name;
  File? avatar;
  AuthChangeUserDetailsEvent(this.name,this.avatar);
}
