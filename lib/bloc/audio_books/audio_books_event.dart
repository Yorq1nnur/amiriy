part of 'audio_books_bloc.dart';

sealed class AudioBooksEvent extends Equatable {
  const AudioBooksEvent();
}

class ListenAudioBooksEvent extends AudioBooksEvent {
  @override
  List<Object?> get props => [];
}

class SearchAudioBooksEvent extends AudioBooksEvent {
  final String query;
  // final List<AudioBooksModel> audios;

  const SearchAudioBooksEvent({
    required this.query,
    // required this.audios,
  });

  @override
  List<Object?> get props => [
        query,
        // audios,
      ];
}
