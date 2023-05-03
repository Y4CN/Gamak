import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/passBloc/passEvent.dart';
import 'package:game_hacks_chat/bloc/passBloc/passState.dart';

class PassBloc extends Bloc<PassEvent,PassState>{
  PassBloc():super(PassInitState()){
    on<PassChangeEvent>((event, emit) {
      emit(PassResponseState(event.show));
    });
  }

}