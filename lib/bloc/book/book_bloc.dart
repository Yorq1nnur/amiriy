import 'package:amiriy/bloc/book/book_event.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/data/repositories/book_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc(this.bookRepo) : super(BookState.initial()) {
    on<ListenAllBooksEvent>(_listenAllBooks);
  }

  BookRepo bookRepo;

  _listenAllBooks(ListenAllBooksEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

await emit.onEach(
      bookRepo.listenAllBooks(),
      onData: (List<BookModel> allBooks) {
        emit(
          state.copyWith(
            formStatus: FormStatus.success,
            books: allBooks,
          ),
        );
      },
      onError: (e, s) {
        emit(
          state.copyWith(
            formStatus: FormStatus.error,
            errorText: e.toString(),
          ),
        );
      },
    );
  }
}
