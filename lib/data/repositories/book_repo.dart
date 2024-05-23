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
          (event) =>
              event.docs.map((doc) => BookModel.fromJson(doc.data())).toList(),
        );
  }

  Stream<List<BookModel>> listenProductsByCategory(
          {required String categoryDocId}) =>
      FirebaseFirestore.instance
          .collection(AppConstants.books)
          .where("category_id", isEqualTo: categoryDocId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => BookModel.fromJson(doc.data()))
              .toList());
}
