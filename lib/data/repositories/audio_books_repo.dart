import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AudioBooksRepo {
  Stream<List<AudioBooksModel>> listenAllBooks() => FirebaseFirestore.instance
      .collection(AppConstants.audioBooks)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => AudioBooksModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );
}
