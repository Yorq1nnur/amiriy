class BookModel {
  final String docId;
  final String bookName;
  final String bookAuthor;
  final String rate;
  final String bookDescription;
  final double price;
  final String imageUrl;
  final String pdfBookUrl;
  final String dateTime;
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
    required this.dateTime,
    required this.pdfBookUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      docId: json[BookModelFields.docId] as String? ?? "",
      imageUrl: json[BookModelFields.imageUrl] as String? ?? "",
      pdfBookUrl: json[BookModelFields.pdfBookUrl] as String? ?? "",
      categoryId: json[BookModelFields.categoryId] as String? ?? "",
      categoryName: json[BookModelFields.categoryName] as String? ?? "",
      bookName: json[BookModelFields.bookName] as String? ?? "",
      bookDescription: json[BookModelFields.bookDescription] as String? ?? "",
      price: (json[BookModelFields.price] as num? ?? 0.0).toDouble(),
      rate: json[BookModelFields.rate] as String? ?? "",
      bookAuthor: json[BookModelFields.bookAuthor] as String? ?? "",
      dateTime: json[BookModelFields.dateTime] as String? ?? "",
    );
  }
}

class BookModelFields {
  static const String docId = 'doc_id';
  static const String imageUrl = 'image_url';
  static const String pdfBookUrl = 'pdf_book_url';
  static const String categoryId = 'category_id';
  static const String categoryName = 'category_name';
  static const String bookName = 'product_name';
  static const String bookDescription = 'product_description';
  static const String price = 'price';
  static const String rate = 'rate';
  static const String bookAuthor = 'book_author';
  static const String dateTime = 'date_time';
}
