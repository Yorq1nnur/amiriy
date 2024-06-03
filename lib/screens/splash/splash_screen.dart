import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_state.dart';
import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_event.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/user/user_bloc.dart';
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
  _init(bool auth) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    if (!auth) {
      Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
    } else {
      BlocProvider.of<UserBloc>(context)
          .add(GetUserEvent(userId: FirebaseAuth.instance.currentUser!.uid));
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }

  @override
  void initState() {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == FormStatus.authenticated) {
                _init(true);
              }
              if (state.status == FormStatus.unauthenticated) {
                _init(false);
              }
            },
            child: const SizedBox.shrink(),
          ),
          Center(
            child: Lottie.asset(
              AppImages.lottie,
            ),
          ),
        ],
      ),
    );
  }
}
