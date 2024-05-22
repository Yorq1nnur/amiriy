import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_event.dart';
import 'package:amiriy/bloc/banner/banner_bloc.dart';
import 'package:amiriy/bloc/banner/banner_event.dart';
import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_event.dart';
import 'package:amiriy/bloc/bottom/bottom_bloc.dart';
import 'package:amiriy/bloc/category/category_bloc.dart';
import 'package:amiriy/bloc/category/category_event.dart';
import 'package:amiriy/bloc/image/image_bloc.dart';
import 'package:amiriy/bloc/notification/notification_bloc.dart';
import 'package:amiriy/bloc/notification/notification_event.dart';
import 'package:amiriy/data/repositories/auth_repository.dart';
import 'package:amiriy/data/repositories/banner_repository.dart';
import 'package:amiriy/data/repositories/book_repo.dart';
import 'package:amiriy/data/repositories/category_repo.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/app_theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (_) => BookRepo(),
        ),
        RepositoryProvider(
          create: (_) => CategoryRepo(),
        ),
        RepositoryProvider(
          create: (_) => BannerRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(
                CheckAuthenticationEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => BottomBloc(),
          ),
          BlocProvider(
            create: (context) => ImageBloc(),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
              context.read<CategoryRepo>(),
            )..add(
                GetAllCategoriesEvent(),
              ),
          ),
          BlocProvider(
            create: (context) =>
                NotificationBloc()..add(NotificationCallEvent()),
          ),
          BlocProvider(
            create: (context) => BannerBloc(
              bannerRepository: context.read<BannerRepository>(),
            )..add(
                GetBannerEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => BookBloc(
              context.read<BookRepo>(),
            ),
          ),
        ],
        child: AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) {
            return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splashScreen,
              onGenerateRoute: AppRoutes.generateRoute,
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
