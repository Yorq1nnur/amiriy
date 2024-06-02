import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_utils/my_utils.dart';
import '../../utils/colors/app_colors.dart';

class CustomTexField extends StatelessWidget {
  const CustomTexField(
      {super.key,
        required this.controller,
        required this.focusNode,
        this.hintText,
        this.maxLines,
        this.minLines,
        this.width,
        required this.fromKey,
        this.validateEmptyText,
        this.validate,
        this.validateText,
        required this.type,
        required this.inputFormatter,
        required this.action});

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final String? validateText;
  final int? maxLines;
  final int? minLines;
  final double? width;
  final String? validateEmptyText;
  final TextInputType type;
  final RegExp? validate;
  final GlobalKey fromKey;
  final TextInputAction action;
  final List<TextInputFormatter> inputFormatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 62,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        style: Theme.of(context).textTheme.bodyMedium,
        inputFormatters: inputFormatter,
        keyboardType: type,
        textInputAction: action,
        maxLines: maxLines,
        minLines: minLines,
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
