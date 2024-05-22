import 'package:amiriy/screens/auth/login/login_screen.dart';
import 'package:amiriy/screens/auth/register/register_screen.dart';
import 'package:amiriy/screens/languages/languages_screen.dart';
import 'package:amiriy/screens/on_boarding/on_boarding_screen.dart';
import 'package:amiriy/screens/one_category/one_category_screen.dart';
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
        return navigate(
          const LoginScreen(),
        );
      case RouteNames.registerRoute:
        return navigate(
          const RegisterScreen(),
        );
      case RouteNames.languagesRoute:
        return navigate(
          const LanguagesScreen(),
        );
      case RouteNames.oneCategoryRoute:
        return navigate(
          OneCategoryScreen(
            categoryName: settings.arguments as String,
          ),
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
  static const String registerRoute = "/register_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String languagesRoute = "/languages_route";
  static const String oneCategoryRoute = "/one_category_route";
}
