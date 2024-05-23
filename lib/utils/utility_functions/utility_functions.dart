import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class UtilityFunctions {
  static void methodPrint(dynamic value) {
    debugPrint(
      "\$\$\$\$\$\n$value\n\$\$\$\$\$",
    );
  }

  static Widget buildRatingStars(double rating, MainAxisAlignment mainAxisAlignment) {
    List<Widget> stars = [];

    for (int i = 1; i <= 5; i++) {
      if (rating >= i) {
        stars.add(
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20.w,
          ),
        );
      } else if (rating > (i - 1) && rating < i) {
        stars.add(
          Icon(
            Icons.star_half,
            color: Colors.yellow,
            size: 20.w,
          ),
        );
      } else {
        stars.add(
          Icon(
            Icons.star_border,
            color: Colors.yellow,
            size: 20.w,
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }

  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static String timeAgo(DateTime dateTime) {
    debugPrint(DateTime.now().toString());
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365} yil oldin';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30} oy oldin';
    } else if (difference.inDays > 7) {
      return '${difference.inDays ~/ 7} hafta oldin';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} kun oldin';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} soat oldin';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} daqiqa oldin';
    } else if (difference.inSeconds > 1) {
      return '${difference.inSeconds} sekund oldin';
    } else {
      return 'hozir';
    }
  }

  static showErrorForRegister(
    String code,
    BuildContext context,
  ) {
    if (code == 'weak-password') {
      debugPrint('The password provided is too weak.');
      if (!context.mounted) return;
      showSnackBar(
        "Passwordni xato kiritdingiz",
        context,
      );
    } else if (code == 'email-already-in-use') {
      debugPrint('The account already exists for that email.');
      if (!context.mounted) return;
      showSnackBar(
        "Bu e-pochta uchun hisob allaqachon mavjud.",
        context,
      );
    }
  }

  static showErrorForLogin(
    String code,
    BuildContext context,
  ) {
    if (code == 'wrong-password') {
      debugPrint('The password provided is wrong.');
      if (!context.mounted) return;
      showSnackBar(
        "Passwordni xato kiritdingiz",
        context,
      );
    } else if (code == 'invalid-email') {
      debugPrint('The e-mail is invalid.');
      if (!context.mounted) return;
      showSnackBar(
        "Bu e-pochta yaqroqsiz.",
        context,
      );
    } else if (code == 'user-disabled') {
      debugPrint('The user is blocked.');
      if (!context.mounted) return;
      showSnackBar(
        "Foydalanuvchi bloklangan.",
        context,
      );
    } else {
      debugPrint('The user is not found.');
      if (!context.mounted) return;
      showSnackBar(
        "Foydalanuvchi topilmadi.",
        context,
      );
    }
  }
}
