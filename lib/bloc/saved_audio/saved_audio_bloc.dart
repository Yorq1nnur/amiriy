import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/local/saved_audio_db.dart';
import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'saved_audio_event.dart';
import 'saved_audio_state.dart';

class SavedAudioBloc extends Bloc<SavedAudioEvent, SavedAudioState> {
  SavedAudioBloc(this.savedAudioDb) : super(SavedAudioState.initial()) {
    on<InsertAudioToDbEvent>(_addAudioToDb);
    on<DeleteAudioFromSavedEvent>(_deleteAudioFromDb);
    on<ListenSavedAudioBooksEvent>(_getAllAudiosFromDb);
    on<FetchSavedAudioBookEvent>(_fetchAudioFromDb);
  }

  final SavedAudioDb savedAudioDb;

  _addAudioToDb(InsertAudioToDbEvent event, emit) async {
    emit(
      state.copyWith(formStatus: FormStatus.loading),
    );

    NetworkResponse networkResponse = await savedAudioDb.insertProduct(
      event.audioBook,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          statusMessage: networkResponse.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _deleteAudioFromDb(DeleteAudioFromSavedEvent event, emit) async {
    emit(
      state.copyWith(formStatus: FormStatus.loading),
    );

    NetworkResponse networkResponse = await savedAudioDb.deleteProduct(
      event.id,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          statusMessage: networkResponse.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _fetchAudioFromDb(FetchSavedAudioBookEvent event, emit) async {
    emit(
      state.copyWith(formStatus: FormStatus.loading),
    );

    NetworkResponse networkResponse = await savedAudioDb.fetchAllProducts();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          savedAudioBooks: networkResponse.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _getAllAudiosFromDb(ListenSavedAudioBooksEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    await emit.onEach(savedAudioDb.listenLatestProducts(),
        onData: (List<AudioBooksModel> audios) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          savedAudioBooks: audios,
        ),
      );
    }, onError: (e, s) {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: e.toString(),
        ),
      );
    });
  }
}
