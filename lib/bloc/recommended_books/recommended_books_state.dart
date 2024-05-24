import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:equatable/equatable.dart';

class RecommendedBooksState extends Equatable {
  final String errorMessage;
  final List<BookModel> recommendedBooks;
  final List<BookModel> lastTenBooks;
  final FormStatus formStatus;
  final String statusMessage;

  const RecommendedBooksState({
    required this.formStatus,
    required this.errorMessage,
    required this.recommendedBooks,
    required this.statusMessage,
    required this.lastTenBooks,
  });

  RecommendedBooksState copyWith({
    String? errorMessage,
    String? statusMessage,
    List<BookModel>? recommendedBooks,
    List<BookModel>? lastTenBooks,
    FormStatus? formStatus,
  }) =>
      RecommendedBooksState(
        formStatus: formStatus ?? this.formStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        statusMessage: statusMessage ?? this.statusMessage,
        recommendedBooks: recommendedBooks ?? this.recommendedBooks,
        lastTenBooks: lastTenBooks ?? this.lastTenBooks,
      );

  static RecommendedBooksState initial() => const RecommendedBooksState(
        formStatus: FormStatus.pure,
        errorMessage: '',
        statusMessage: '',
        recommendedBooks: [],
        lastTenBooks: [],
      );

  @override
  List<Object?> get props => [
        errorMessage,
        recommendedBooks,
        formStatus,
        statusMessage,
        lastTenBooks,
      ];
}
