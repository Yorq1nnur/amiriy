import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../data/models/category_model.dart';
import '../utils/constants/app_constants.dart';
import '../utils/utility_functions.dart';

class CategoriesViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<CategoryModel> categories = [];

  CategoriesViewModel() {
    getCategories();
  }

  Future<void> getCategories() async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((snapshot) {
      categories =
          snapshot.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  Stream<List<CategoryModel>> listenCategories() {
    return FirebaseFirestore.instance
        .collection(
          AppConstants.categories,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map((doc) => CategoryModel.fromJson(doc.data()))
              .toList(),
        );
  }

  insertCategory(CategoryModel categoryModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .add(categoryModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
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

  updateCategory(CategoryModel categoryModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(categoryModel.docId)
          .update(categoryModel.toJsonForUpdate());

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(
        context: context,
        message: error.code,
      );
    }
  }

  deleteCategory(CategoryModel categoryModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(categoryModel.docId)
          .delete();
      FirebaseStorage.instance.ref().child(categoryModel.imageUrl).delete();
      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackBar(
        context: context,
        message: error.code,
      );
    }
  }

  Future<void> deleteProductsByCategory({required String categoryDocId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(AppConstants.books)
              .where("category_id", isEqualTo: categoryDocId)
              .get();

      final List<Future<void>> deleteFutures = [];

      for (final doc in querySnapshot.docs) {
        deleteFutures.add(doc.reference.delete());
      }

      await Future.wait(deleteFutures);
      debugPrint("All products in category $categoryDocId deleted successfully");
    } catch (error) {
      debugPrint("Error deleting products: $error");
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
