import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_utils/my_utils.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.voidCallback,
  });

  final TextEditingController controller;
  final Function(String v) voidCallback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      onChanged: voidCallback,
      controller: controller,
      decoration: InputDecoration(
        hintText: "search_books".tr(),
        prefixIcon: Transform.scale(
          scale: 0.7,
          child: SvgPicture.asset(AppImages.search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.black,
            width: 8.h,
          ),
        ),
      ),
    );
  }
}
