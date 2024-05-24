import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:equatable/equatable.dart';

class RecommendedBooksState extends Equatable {
  final String errorMessage;
  final List<BookModel> recommendedBooks;
  final FormStatus formStatus;

  const RecommendedBooksState({
    required this.formStatus,
    required this.errorMessage,
    required this.recommendedBooks,
  });

  RecommendedBooksState copyWith({
    String? errorMessage,
    List<BookModel>? recommendedBooks,
    FormStatus? formStatus,
  }) =>
      RecommendedBooksState(
        formStatus: formStatus ?? this.formStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        recommendedBooks: recommendedBooks ?? this.recommendedBooks,
      );

  static RecommendedBooksState initial() => const RecommendedBooksState(
        formStatus: FormStatus.pure,
        errorMessage: '',
        recommendedBooks: [],
      );

  @override
  List<Object?> get props => [
        errorMessage,
        recommendedBooks,
        formStatus,
      ];
}
