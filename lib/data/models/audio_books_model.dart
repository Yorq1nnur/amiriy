class AudioBooksModel {
  final String bookName;
  final String bookUrl;
  final int id;

  AudioBooksModel({
    required this.bookName,
    required this.bookUrl,
    required this.id,
  });

  factory AudioBooksModel.fromJson(Map<String, dynamic> json) =>
      AudioBooksModel(
        bookName: json[AudioBooksFields.bookName] as String? ?? 'AUDIO BOOK',
        id: json[AudioBooksFields.id] as int? ?? 0,
        bookUrl: json[AudioBooksFields.bookUrl] as String? ??
            "gs://e-commerce-app-863de.appspot.com/files/musics/''O'mrov suyagi'' hikoyasi - Aziz Nesin.mp3",
      );

  Map<String, dynamic> toJson() => {
        AudioBooksFields.bookName: bookName,
        AudioBooksFields.bookUrl: bookUrl,
      };
}

class AudioBooksFields {
  static const String bookName = 'book_name';
  static const String bookUrl = 'book_url';
  static const String id = 'id';

  static const List<String> values = [
    bookName,
    bookUrl,
    id,
  ];
}
