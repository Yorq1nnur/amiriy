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

import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    if (!mounted) return;
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }

  @override
  void initState() {
    _init();
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
