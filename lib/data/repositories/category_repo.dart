import 'package:amiriy/data/models/category_model.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepo {
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
}
