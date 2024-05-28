part of 'audio_books_bloc.dart';

class AudioBooksState extends Equatable {
  final FormStatus formStatus;
  final String errorText;
  final List<AudioBooksModel> audioBooks;

  const AudioBooksState({
    required this.formStatus,
    required this.errorText,
    required this.audioBooks,
  });

  static AudioBooksState initial() => const AudioBooksState(
        formStatus: FormStatus.pure,
        errorText: '',
        audioBooks: [],
      );

  AudioBooksState copyWith({
    FormStatus? formStatus,
    String? errorText,
    List<AudioBooksModel>? audioBooks,
  }) =>
      AudioBooksState(
        formStatus: formStatus ?? this.formStatus,
        errorText: errorText ?? this.errorText,
        audioBooks: audioBooks ?? this.audioBooks,
      );

  @override
  List<Object?> get props => [
        formStatus,
        errorText,
        audioBooks,
      ];
}
