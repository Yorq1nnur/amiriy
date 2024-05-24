import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
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
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(AppConstants.books).get();

      List<BookModel> products = querySnapshot.docs
          .map(
            (e) => BookModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      List<BookModel> recommendedProducts = [];

      for (var element in products) {
        if (double.parse(element.rate) >= 4.5) {
          recommendedProducts.add(
            element,
          );
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

  // Future<NetworkResponse> getLastTenBooks() async {
  //   try {
  //     QuerySnapshot querySnapshot =
  //     await FirebaseFirestore.instance.collection(AppConstants.books).get();
  //
  //     List<BookModel> recentBooks = querySnapshot.docs
  //         .map(
  //           (e) => BookModel.fromJson(e.data() as Map<String, dynamic>),
  //         )
  //         .toList();
  //
  //     List<BookModel> lastTenBooks = UtilityFunctions.getLatest10Dates(recentBooks);
  //
  //
  //
  //
  //
  //     UtilityFunctions.methodPrint(
  //         'LAST TEN BOOKS IS LENGTH: ${recentBooks.length}');
  //
  //     // Return the list of recent books in the NetworkResponse
  //     return NetworkResponse(
  //       data: lastTenBooks,
  //     );
  //   } on FirebaseException catch (error) {
  //     // Return error information in the NetworkResponse
  //     return NetworkResponse(
  //       errorCode: error.code,
  //       errorText: error.message ?? '',
  //     );
  //   }
  // }

  Future<NetworkResponse> getLastTenBooks() async {
    try {
      // Query Firestore for the last 10 documents ordered by 'date_time' field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .orderBy('date_time', descending: true)
          .limit(10)
          .get();

      // Map the documents to BookModel instances
      List<BookModel> recentBooks = querySnapshot.docs
          .map(
            (e) => BookModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();

      //DateTime.now().toString()

      for (var element in recentBooks) {
        UtilityFunctions.methodPrint(element.dateTime);
      }

      // Return the list of recent books in the NetworkResponse
      return NetworkResponse(
        data: recentBooks,
      );
    } on FirebaseException catch (error) {
      // Return error information in the NetworkResponse
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
