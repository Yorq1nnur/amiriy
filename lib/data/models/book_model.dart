class BookModel {
  final String docId;
  final String bookName;
  final String bookAuthor;
  final String rate;
  final String bookDescription;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String categoryName;

  BookModel({
    required this.price,
    required this.imageUrl,
    required this.bookName,
    required this.docId,
    required this.bookDescription,
    required this.categoryId,
    required this.categoryName,
    required this.rate,
    required this.bookAuthor,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      docId: json["doc_id"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
      categoryName: json["category_name"] as String? ?? "",
      bookName: json["product_name"] as String? ?? "",
      bookDescription: json["product_description"] as String? ?? "",
      price: (json["price"] as num? ?? 0.0).toDouble(),
      rate: json["rate"] as String? ?? "",
      bookAuthor: json["book_author"] as String? ?? "",
    );
  }
}
