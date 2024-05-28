class AudioBooksModel {
  final String bookName;
  final String bookUrl;

  AudioBooksModel({
    required this.bookName,
    required this.bookUrl,
  });

  factory AudioBooksModel.fromJson(Map<String, dynamic> json) =>
      AudioBooksModel(
        bookName: json['book_name'] as String? ?? 'AUDIO BOOK',
        bookUrl: json['book_url'] as String? ??
            "gs://e-commerce-app-863de.appspot.com/files/musics/''O'mrov suyagi'' hikoyasi - Aziz Nesin.mp3",
      );
}
