import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:equatable/equatable.dart';

sealed class SavedAudioEvent extends Equatable {
  const SavedAudioEvent();
}

class InsertAudioToDbEvent extends SavedAudioEvent {
  final AudioBooksModel audioBook;

  const InsertAudioToDbEvent({
    required this.audioBook,
  });

  @override
  List<Object?> get props => [
        audioBook,
      ];
}

class ListenSavedAudioBooksEvent extends SavedAudioEvent {
  @override
  List<Object?> get props => [];
}

class FetchSavedAudioBookEvent extends SavedAudioEvent {
  @override
  List<Object?> get props => [];
}

class DeleteAudioFromSavedEvent extends SavedAudioEvent {
  final String bookName;

  const DeleteAudioFromSavedEvent({
    required this.bookName,
  });

  @override
  List<Object?> get props => [
        bookName,
      ];
}
