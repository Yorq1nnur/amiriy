// import 'package:amiriy/utils/images/app_images.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import '../routes.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   _init() async {
//     await Future.delayed(
//       const Duration(seconds: 2),
//     );
//     if (!mounted) return;
//
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
//     } else {
//       Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
//     }
//   }
//
//   @override
//   void initState() {
//     _init();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Lottie.asset(
//           AppImages.lottie,
//         ),
//       ),
//     );
//   }
// }

import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/local/storage_repository.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_utils/my_utils.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../utils/colors/app_colors.dart';

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
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      }
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == FormStatus.authenticated) {
                    _init(true);
                  } else {
                    _init(false);
                  }
                },
                child: const SizedBox.square(),
              ),
              Lottie.asset(AppImages.lottie),
            ],
          ),
        ),
      ),
    );
  }
}
