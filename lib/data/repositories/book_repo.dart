import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookRepo {
  Stream<List<BookModel>> listenAllBooks() {
    return FirebaseFirestore.instance
        .collection(
      AppConstants.books,
    )
        .snapshots()
        .map(
          (event) => event.docs
          .map((doc) => BookModel.fromJson(doc.data()))
          .toList(),
    );
  }
}
