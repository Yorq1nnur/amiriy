class CategoryModel {
  final String docId;
  final String categoryName;
  final String imageUrl;

  CategoryModel({
    required this.imageUrl,
    required this.categoryName,
    required this.docId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      docId: json[CategoryModelFields.docId] as String? ?? "",
      imageUrl: json[CategoryModelFields.imageUrl] as String? ?? "",
      categoryName: json[CategoryModelFields.categoryName] as String? ?? "",
    );
  }
}

class CategoryModelFields {
  static const String docId = 'doc_id';
  static const String imageUrl = 'image_url';
  static const String categoryName = 'category_name';
}
