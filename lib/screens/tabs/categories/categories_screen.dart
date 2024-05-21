import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          "Categories",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.addCategoryRoute,
              );
            },
            child: const Icon(
              Icons.add,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
