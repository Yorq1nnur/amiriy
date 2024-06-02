import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/recommended_books/recommended_books_event.dart';
import 'package:amiriy/bloc/recommended_books/recommended_books_state.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/data/repositories/book_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedBooksBloc
    extends Bloc<RecommendedBooksEvent, RecommendedBooksState> {
  RecommendedBooksBloc(
    this.bookRepo,
  ) : super(RecommendedBooksState.initial()) {
    on<GetRecommendedBooksEvent>(_getRecommendedBooks);
    on<GetLastTenBooksEvent>(_getLastTenBooks);
  }

  BookRepo bookRepo;

  _getLastTenBooks(GetLastTenBooksEvent event, emit) async {
    emit(
      state.copyWith(
        statusMessage: 'last_ten_loading',
      ),
    );

    NetworkResponse networkResponse = await bookRepo.getLastTenBooks();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          statusMessage: 'last_ten_success',
          lastTenBooks: networkResponse.data,
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

  _getRecommendedBooks(GetRecommendedBooksEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    await emit.onEach(bookRepo.getRecommendedBooks(),
        onData: (List<BookModel> recommendedBooks) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          recommendedBooks: recommendedBooks,
        ),
      );
    }, onError: (error, stackTree) {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: error.toString(),
        ),
      );
    });
  }
}
