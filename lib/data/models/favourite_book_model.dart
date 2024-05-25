class FavouriteBookModel {
  final String bookDocId;
  final String favouriteDocId;
  final String userId;
  final String bookName;
  final String bookAuthor;
  final String rate;
  final String bookDescription;
  final double price;
  final String imageUrl;
  final String dateTime;
  final String categoryId;
  final String categoryName;

  FavouriteBookModel({
    required this.bookDocId,
    required this.categoryId,
    required this.categoryName,
    required this.dateTime,
    required this.bookDescription,
    required this.bookName,
    required this.rate,
    required this.imageUrl,
    required this.bookAuthor,
    required this.price,
    required this.userId,
    required this.favouriteDocId,
  });

  factory FavouriteBookModel.fromJson(Map<String, dynamic> json) {
    return FavouriteBookModel(
      bookDocId: json["book_doc_id"] as String? ?? "",
      favouriteDocId: json["favourite_doc_id"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
      categoryName: json["category_name"] as String? ?? "",
      bookName: json["product_name"] as String? ?? "",
      bookDescription: json["product_description"] as String? ?? "",
      price: (json["price"] as num? ?? 0.0).toDouble(),
      rate: json["rate"] as String? ?? "",
      bookAuthor: json["book_author"] as String? ?? "",
      dateTime: json["date_time"] as String? ?? "",
      userId: json["user_id"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "book_doc_id": bookDocId,
      "favourite_doc_id": bookDocId,
      "user_id": userId,
      "product_name": bookName,
      "book_author": bookAuthor,
      "rate": rate,
      "product_description": bookDescription,
      "price": price,
      "image_url": imageUrl,
      "date_time": dateTime,
      "category_id": categoryId,
      "category_name": categoryName,
    };
  }

  FavouriteBookModel copyWith({
    String? bookDocId,
    String? favouriteDocId,
    String? userId,
    String? bookName,
    String? bookAuthor,
    String? rate,
    String? bookDescription,
    double? price,
    String? imageUrl,
    String? dateTime,
    String? categoryId,
    String? categoryName,
  }) {
    return FavouriteBookModel(
      bookDocId: bookDocId ?? this.bookDocId,
      favouriteDocId: favouriteDocId ?? this.favouriteDocId,
      userId: userId ?? this.userId,
      bookName: bookName ?? this.bookName,
      bookAuthor: bookAuthor ?? this.bookAuthor,
      rate: rate ?? this.rate,
      bookDescription: bookDescription ?? this.bookDescription,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      dateTime: dateTime ?? this.dateTime,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}
