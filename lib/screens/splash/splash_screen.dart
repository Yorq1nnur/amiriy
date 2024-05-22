import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_event.dart';
import 'package:amiriy/data/local/storage_repository.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_utils/my_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isNewUser = StorageRepository.getBool(key: 'is_new_user');

    if (!mounted) return;

    if (isNewUser) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.loginRoute,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.tabRoute,
        );
      }
    } else {
      Navigator.pushReplacementNamed(
        context,
        RouteNames.onBoardingRoute,
      );
    }
  }

  @override
  void initState() {
    _init();
    Future.microtask(
      () => context.read<BookBloc>().add(
            ListenAllBooksEvent(),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppImages.lottie,
        ),
      ),
    );
  }
}
