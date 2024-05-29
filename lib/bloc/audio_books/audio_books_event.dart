part of 'audio_books_bloc.dart';

sealed class AudioBooksEvent extends Equatable {
  const AudioBooksEvent();
}

class ListenAudioBooksEvent extends AudioBooksEvent {
  @override
  List<Object?> get props => [];
}
