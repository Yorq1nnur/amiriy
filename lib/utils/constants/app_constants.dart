class AppConstants {
  static RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static RegExp passwordRegExp = RegExp(r"^(?=.*[A-Z]).{8,}$");
  static RegExp telegramOnlyLettersAndNumbersWithoutFirstCapital =
      RegExp(r'^[a-z0-9]+$');
  static RegExp noMinusOrLettersNoZero = RegExp(r'^[^0a-zA-Z-]');

  static RegExp textRegExp = RegExp("[a-zA-Z]");
  static RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  static const String clientID =
      "762812355330-nn0liimku3ot544gkpv8rptbm534hc7s.apps.googleusercontent.com";
  static const String banners = "banners";
  static const String audioBooks = "audio_books";
  static const String savedAudioDb = "saved_audio.db";
  static const String savedAudio = "saved_audio";
  static const String favourites = "favourites";

  static const String categories = "categories";
  static const String books = "books";

  static const String translations = "assets/translations";
}
