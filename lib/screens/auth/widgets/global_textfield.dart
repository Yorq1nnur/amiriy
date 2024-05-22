import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_utils/my_utils.dart';
import '../../../utils/colors/app_colors.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField({
    super.key,
    required this.title,
    this.focusNode,
    required this.icon,
    this.controller,
    required this.validate,
    required this.validateText,
    required this.validateEmptyText,
    required this.formKey,
    required this.type,
    required this.inputFormatter,
    required this.onChanged,
  });

  final FocusNode? focusNode;
  final String title;
  final String validateText;
  final String validateEmptyText;
  final Widget icon;
  final TextEditingController? controller;
  final RegExp validate;
  final GlobalKey formKey;
  final TextInputType type;
  final List<TextInputFormatter> inputFormatter;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.c9D9EA8.withOpacity(0.18),
              blurRadius: 62,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14.sp),
          onChanged: onChanged,
          inputFormatters: inputFormatter,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return validateEmptyText.tr();
            }
            if (!validate.hasMatch(value) || value.length < 3) {
              return validateText.tr();
            }
            return null;
          },
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            isDense: true,
            contentPadding: EdgeInsets.only(top: 17.h, bottom: 17.h),
            prefixIcon: icon,
            hintText: title,
            hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 14.w,
                ),
          ),
        ),
      ),
    );
  }
}
