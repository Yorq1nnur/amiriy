import 'package:amiriy/data/models/book_model.dart';
import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class ListenAllBooksEvent extends BookEvent {
  @override
  List<Object?> get props => [];
}

class SearchProductsProductsEvent extends BookEvent {
  final List<BookModel> books;
  final String query;
  final bool isCategoryProducts;

  const SearchProductsProductsEvent({
    required this.query,
    required this.isCategoryProducts,
    required this.books,
  });

  @override
  List<Object?> get props => [
        query,
        isCategoryProducts,
        books,
      ];
}

class GetBooksByCategoryId extends BookEvent {
  final String categoryId;

  const GetBooksByCategoryId({
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        categoryId,
      ];
}
