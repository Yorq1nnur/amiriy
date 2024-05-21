class AppConstants {
  static final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  static final RegExp textRegExp = RegExp("[a-zA-Z]");
  static final RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  static const String clientID =
      "762812355330-nn0liimku3ot544gkpv8rptbm534hc7s.apps.googleusercontent.com";
  static const String banners = "banners";

  static const String categories = "categories";
  static const String books = "books";
}
