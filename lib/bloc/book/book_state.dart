import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:equatable/equatable.dart';

class BookState extends Equatable {
  final FormStatus formStatus;
  final String errorText;
  final String statusMessage;
  final List<BookModel> books;
  final List<BookModel> categoryBooks;

  const BookState({
    required this.formStatus,
    required this.errorText,
    required this.statusMessage,
    required this.books,
    required this.categoryBooks,
  });

  BookState copyWith({
    FormStatus? formStatus,
    String? errorText,
    String? statusMessage,
    List<BookModel>? books,
    List<BookModel>? categoryBooks,
  }) =>
      BookState(
        formStatus: formStatus ?? this.formStatus,
        errorText: errorText ?? this.errorText,
        statusMessage: statusMessage ?? this.statusMessage,
        books: books ?? this.books,
        categoryBooks: categoryBooks ?? this.categoryBooks,
      );

  static BookState initial() => const BookState(
        formStatus: FormStatus.pure,
        errorText: '',
        statusMessage: '',
        books: [],
        categoryBooks: [],
      );

  @override
  List<Object?> get props => [
        categoryBooks,
        books,
        statusMessage,
        errorText,
        formStatus,
      ];
}
