class AudioBooksModel {
  final String bookName;
  final String bookUrl;
  final String imageUrl;
  final int id;

  AudioBooksModel({
    required this.bookName,
    required this.bookUrl,
    required this.imageUrl,
    required this.id,
  });

  factory AudioBooksModel.fromJson(Map<String, dynamic> json) =>
      AudioBooksModel(
        bookName: json[AudioBooksFields.bookName] as String? ?? '',
        imageUrl: json[AudioBooksFields.imageUrl] as String? ?? '',
        id: json[AudioBooksFields.id] as int? ?? 0,
        bookUrl: json[AudioBooksFields.bookUrl] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        AudioBooksFields.bookName: bookName,
        AudioBooksFields.bookUrl: bookUrl,
      };
}

class AudioBooksFields {
  static const String bookName = 'book_name';
  static const String imageUrl = 'image_url';
  static const String bookUrl = 'book_url';
  static const String id = 'id';

  static const List<String> values = [
    bookName,
    bookUrl,
    id,
    imageUrl,
  ];
}
