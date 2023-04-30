import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_hacks_chat/bloc/supportBloc/supportEvent.dart';
import 'package:game_hacks_chat/bloc/supportBloc/supportState.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportInitState()) {
    on<SupportSendEmailEvent>((event, emit) async {
      emit(SupportLoadingState());
      try {
        var lunch = await launchUrl(
        Uri(
          scheme: 'mailto',
          path: 'gamaknotifications@gmail.com',
          queryParameters: {'subject': event.title, 'body': event.description},
        ),
        // mode: LaunchMode.
      );
      if (lunch) {
        emit(SupportResponseState());
      } else {
        emit(SupportErrorState());
      }
      } catch (e) {
        print(e.toString());
        emit(SupportErrorState());
      }
      
      
    });
  }
}
