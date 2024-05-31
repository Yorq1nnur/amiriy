import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/auth/login/login_screen.dart';
import 'package:amiriy/screens/auth/register/register_screen.dart';
import 'package:amiriy/screens/categories/categories_screen.dart';
import 'package:amiriy/screens/details/book_details_screen.dart';
import 'package:amiriy/screens/favourite_audio_books/favourite_audio_books_screen.dart';
import 'package:amiriy/screens/languages/languages_screen.dart';
import 'package:amiriy/screens/on_boarding/on_boarding_screen.dart';
import 'package:amiriy/screens/one_category/one_category_screen.dart';
import 'package:amiriy/screens/pdf_view/pdf_view_screen.dart';
import 'package:amiriy/screens/player/player_screen.dart';
import 'package:amiriy/screens/splash/splash_screen.dart';
import 'package:amiriy/screens/tabs/tab_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(
          const SplashScreen(),
        );
      case RouteNames.onBoardingRoute:
        return navigate(
          const OnBoardingScreen(),
        );

      case RouteNames.tabRoute:
        return navigate(
          const TabScreen(),
        );
      case RouteNames.loginRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.registerRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const RegisterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.languagesRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LanguagesScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.oneCategoryRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              OneCategoryScreen(
            categoryDetails: settings.arguments as Map<String, dynamic>,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.bookDetailsRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BookDetailsScreen(
            bookModel: settings.arguments as BookModel,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.favouriteAudioBooksScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const FavouriteAudioBooksScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.categoryRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const CategoriesScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.playerScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => PlayerScreen(
            music: settings.arguments as AudioBooksModel,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteNames.pdfViewRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PdfViewScreen(
            bookModel: settings.arguments as BookModel,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(
    Widget widget,
  ) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String loginRoute = "/login_route";
  static const String playerScreen = "/player_screen";
  static const String registerRoute = "/register_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String languagesRoute = "/languages_route";
  static const String pdfViewRoute = "/pdf_view_route";
  static const String oneCategoryRoute = "/one_category_route";
  static const String categoryRoute = "/category_route";
  static const String bookDetailsRoute = "/book_details_route";
  static const String favouriteAudioBooksScreen =
      "/favourite_audio_books_screen";
}
