import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/authBloc/authEvent.dart';
import 'package:game_hacks_chat/bloc/authBloc/authState.dart';
import 'package:game_hacks_chat/data/repository/authRepository.dart';
import 'package:game_hacks_chat/locator.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository = locator.get();
  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      var login =
          await _authRepository.login(event.emailOruserName, event.passwrod);
      emit(AuthLoginResponseState(login));
    });

    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      var register = await _authRepository.register(
        event.email,
        event.userName,
        event.name,
        event.password,
        event.passwordConfirm,
        event.avatar,
      );
      emit(AuthRegisterResponseState(register));
    });
  }
}
