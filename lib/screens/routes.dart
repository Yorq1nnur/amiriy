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

      case RouteNames.tabRoute:
        return navigate(
          const TabScreen(),
        );

      // case RouteNames.loginRoute:
      //   return navigate(
      //     const LoginScreen(),
      //   );

      // case RouteNames.registerRoute:
      //   return navigate(
      //     const RegisterScreen(),
      //   );
      // case RouteNames.addCategoryRoute:
      //   return navigate(
      //     const AddCategoryScreen(),
      //   );
      // case RouteNames.addBookRoute:
      //   return navigate(
      //     const AddBookScreen(),
      //   );
      // case RouteNames.newsRoute:
      //   return navigate(
      //     const NewsScreen(),
      //   );
      // case RouteNames.profileRoute:
      //   return navigate(
      //     const ProfileScreen(),
      //   );

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
  static const String addCategoryRoute = "/add_category_route";
  static const String addBookRoute = "/add_book_route";
  static const String newsRoute = "/news_route";
  static const String profileRoute = "/profile_route";
  static const String notificationScreen = 'notification_Screen';

}
