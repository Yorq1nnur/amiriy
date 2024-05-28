import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/data/repositories/audio_books_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_books_event.dart';

part 'audio_books_state.dart';

class AudioBooksBloc extends Bloc<AudioBooksEvent, AudioBooksState> {
  AudioBooksBloc(
    this.audioBooksRepo,
  ) : super(AudioBooksState.initial()) {
    on<ListenAudioBooksEvent>(_listenAudioBooks);
  }

  final AudioBooksRepo audioBooksRepo;

  _listenAudioBooks(ListenAudioBooksEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    await emit.onEach(audioBooksRepo.listenAllBooks(),
        onData: (List<AudioBooksModel> audios) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          audioBooks: audios,
        ),
      );
    }, onError: (e, s) {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: e.toString(),
        ),
      );
    });
  }
}
