import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/data/repository/authRepository.dart';
import 'package:game_hacks_chat/locator.dart';
import 'package:game_hacks_chat/utilities/errorHandler.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository = locator.get();
  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        var login =
            await _authRepository.login(event.emailOruserName, event.passwrod);
        emit(AuthLoginResponseState(login));
      } catch (e) {
        emit(AuthLoginErrorState('رمز عبور یا نام کاربری/ایمیل شما اشتباه هست'));
      }
    });

    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        var register = await _authRepository.register(
          event.email,
          event.userName,
          event.name,
          event.password,
          event.passwordConfirm,
          event.avatar,
        );
        emit(AuthRegisterResponseState(register));
      } catch (e) {
        emit(AuthRegisterErrorState("خطای ناشناخته"));
      }
    });

    on<AuthReadUserEvent>((event, emit) async {
      emit(AuthLoadingState());
      var responseUser = await _authRepository.readUser();
      emit(AuthReadUserResponseState(responseUser));
    });

    on<AuthVerifyEvent>((event, emit) async {
      // emit(AuthLoadingState());
      var response = await _authRepository.verify(event.email);
      emit(AuthVerifyResponseState(response));
    });

    on<AuthForgotPassEvent>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _authRepository.forGotPass(event.email);
      emit(AuthForgotPassResponseState(response));
    });

    on<AuthChangeUserDetailsEvent>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _authRepository.changeUser(event.name, event.avatar);
      emit(AuthEditUserDetailsResponseState(response));
    });
  }
}
