import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/data/models/favourite_book_model.dart';
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

  Stream<List<BookModel>> getRecommendedBooks() async* {
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

      yield recommendedProducts;
    } on FirebaseException catch (error) {
      throw Exception(error);
    }
  }

  Future<NetworkResponse> getLastTenBooks() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .orderBy('date_time', descending: true)
          .limit(10)
          .get();

      List<BookModel> recentBooks = querySnapshot.docs
          .map(
            (e) => BookModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();

      for (var element in recentBooks) {
        UtilityFunctions.methodPrint(element.dateTime);
      }

      return NetworkResponse(
        data: recentBooks,
      );
    } on FirebaseException catch (error) {
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? '',
      );
    }
  }

  Stream<List<BookModel>> listenProductsByCategory({
    required String categoryDocId,
  }) =>
      FirebaseFirestore.instance
          .collection(AppConstants.books)
          .where("category_id", isEqualTo: categoryDocId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => BookModel.fromJson(doc.data()))
              .toList());

  Stream<List<FavouriteBookModel>> listenFavouriteProducts({
    required String userId,
  }) =>
      FirebaseFirestore.instance
          .collection(AppConstants.books)
          .where("user_id", isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map(
                (doc) => FavouriteBookModel.fromJson(
                  doc.data(),
                ),
              )
              .toList());

  Future<NetworkResponse> insertFavouriteBook(
      FavouriteBookModel favouriteBookModel) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
            AppConstants.favourites,
          )
          .get();

      List<FavouriteBookModel> favourites = querySnapshot.docs
          .map((e) =>
              FavouriteBookModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      bool isExists = false;

      for (var user in favourites) {
        if (user.favouriteDocId == favouriteBookModel.favouriteDocId) {
          isExists = true;
        }
      }

      if (!isExists) {
        DocumentReference documentReference = await FirebaseFirestore.instance
            .collection(
              AppConstants.favourites,
            )
            .add(
              favouriteBookModel.toJson(),
            );
        await FirebaseFirestore.instance
            .collection(
              AppConstants.favourites,
            )
            .doc(
              documentReference.id,
            )
            .update({
          "favourite_doc_id": documentReference.id,
        });
      }

      return NetworkResponse(
        data: "success",
      );
    } on FirebaseException catch (error) {
      UtilityFunctions.methodPrint(
        error.message,
      );
      return NetworkResponse(
        errorCode: error.code,
        errorText: error.message ?? "NOMA'LUM XATOLIK!!!",
      );
    }
  }

  Future<bool> checkIsExistsFavouriteBook({
    required String favouriteDocId,
  }) async {
    bool isExists = false;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
            AppConstants.favourites,
          )
          .get();

      List<FavouriteBookModel> favourites = querySnapshot.docs
          .map((e) =>
              FavouriteBookModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      for (FavouriteBookModel favourite in favourites) {
        if (favourite.favouriteDocId == favouriteDocId) {
          isExists = true;
        }

        return isExists;
      }
    } on FirebaseException catch (error) {
      UtilityFunctions.methodPrint(error);
      isExists = false;
    }

    return isExists;
  }

  Future<NetworkResponse> deleteFavouriteBook(String favouriteDocId) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            AppConstants.favourites,
          )
          .doc(
            favouriteDocId,
          )
          .delete();

      return NetworkResponse(
        data: "success",
      );
    } on FirebaseException catch (error) {
      UtilityFunctions.methodPrint(
        error.message,
      );
      return NetworkResponse(
        errorText: error.message ?? '',
        errorCode: error.code,
      );
    }
  }
}

/*
Stream<NetworkResponse> getRecommendedBooks() async* {
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

    yield NetworkResponse(
      data: recommendedProducts,
    );
  } on FirebaseException catch (error) {
    yield NetworkResponse(
      errorCode: error.code,
      errorText: error.message ?? '',
    );
  }
}
 */
