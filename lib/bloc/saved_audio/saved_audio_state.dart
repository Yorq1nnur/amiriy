import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:equatable/equatable.dart';

class SavedAudioState extends Equatable {
  final String errorText;
  final String statusMessage;
  final List<AudioBooksModel> savedAudioBooks;
  final List<String> savedAudioBooksName;
  final FormStatus formStatus;

  const SavedAudioState({
    required this.formStatus,
    required this.errorText,
    required this.savedAudioBooks,
    required this.statusMessage,
    required this.savedAudioBooksName,
  });

  SavedAudioState copyWith({
    String? errorText,
    String? statusMessage,
    List<AudioBooksModel>? savedAudioBooks,
    List<String>? savedAudioBooksName,
    FormStatus? formStatus,
  }) =>
      SavedAudioState(
        formStatus: formStatus ?? this.formStatus,
        errorText: errorText ?? this.errorText,
        statusMessage: statusMessage ?? this.statusMessage,
        savedAudioBooks: savedAudioBooks ?? this.savedAudioBooks,
        savedAudioBooksName: savedAudioBooksName ?? this.savedAudioBooksName,
      );

  static SavedAudioState initial() => const SavedAudioState(
        formStatus: FormStatus.pure,
        errorText: '',
        statusMessage: '',
        savedAudioBooks: [],
        savedAudioBooksName: [],
      );

  @override
  List<Object?> get props => [
        errorText,
        statusMessage,
        formStatus,
        savedAudioBooks,
      ];
}
