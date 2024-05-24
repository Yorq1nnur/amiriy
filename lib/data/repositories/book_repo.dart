import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/data/models/network_response.dart';
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

  Future<NetworkResponse> getRecommendedBooks() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .get();

      List<BookModel> products = querySnapshot.docs
          .map(
            (e) => BookModel.fromJson(
          e.data() as Map<String, dynamic>,
        ),
      )
          .toList();

      List<BookModel> recommendedProducts = [];

      for (var element in products) {
        if(double.parse(element.rate) >= 4.5){
          recommendedProducts.add(element,);
        }
      }

      return NetworkResponse(
        data: recommendedProducts,
      );
    } on FirebaseException catch (error) {
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
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
