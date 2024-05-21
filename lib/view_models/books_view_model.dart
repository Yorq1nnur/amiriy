import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../utils/utility_functions.dart';

class BooksViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<BookModel> categoryProduct = [];

  Stream<List<BookModel>> listenProducts() =>
      FirebaseFirestore.instance.collection(AppConstants.books).snapshots().map(
            (event) => event.docs
                .map((doc) => BookModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<BookModel>> listenProductsByCategory(
          {required String categoryDocId}) =>
      FirebaseFirestore.instance
          .collection(AppConstants.books)
          .where("category_id", isEqualTo: categoryDocId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => BookModel.fromJson(doc.data()))
              .toList());

  insertProducts(BookModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .doc(cf.id)
          .update({"doc_id": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(
        context: context,
        message: error.code,
      );
    }
  }

  updateProduct(BookModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(
        context: context,
        message: error.code,
      );
    }
  }

  Future<void> deleteProduct(String docId, BuildContext context) async {
    try {
      _notify(true);

      // Get the document reference
      final DocumentReference<Map<String, dynamic>> docRef =
      FirebaseFirestore.instance.collection(AppConstants.books).doc(docId);

      // Get the document data
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
      await docRef.get();

      // Get the imageUrl field from the document data
      final String? imageUrl = docSnapshot.data()?['image_url'];

      // Delete the document from Firestore
      await docRef.delete();

      // If imageUrl exists, delete the corresponding image from Firebase Storage
      if (imageUrl != null) {
        // Extracting the image name from the URL
        final imageName = imageUrl.split('/').last;
        final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$imageName');

        // Deleting the image from Firebase Storage
        await storageReference.delete();
      }

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(
        context: context,
        message: error.code,
      );
    }
  }


  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
