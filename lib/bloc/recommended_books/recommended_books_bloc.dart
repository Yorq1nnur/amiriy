import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/recommended_books/recommended_books_event.dart';
import 'package:amiriy/bloc/recommended_books/recommended_books_state.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/data/repositories/book_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedBooksBloc
    extends Bloc<RecommendedBooksEvent, RecommendedBooksState> {
  RecommendedBooksBloc(
    this.bookRepo,
  ) : super(RecommendedBooksState.initial()) {
    on<GetRecommendedBooksEvent>(_getRecommendedBooks);
  }

  BookRepo bookRepo;

  _getRecommendedBooks(GetRecommendedBooksEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await bookRepo.getRecommendedBooks();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          recommendedBooks: networkResponse.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }
}
