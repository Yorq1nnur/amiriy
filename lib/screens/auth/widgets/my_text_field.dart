import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.textInputAction,
    required this.textInputType,
    required this.imagePath,
    required this.onChanged,
  });

  final TextEditingController textEditingController;
  final String labelText;
  final String imagePath;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      textInputAction: textInputAction,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: SizedBox(
          width: 50.w,
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              SvgPicture.asset(
                imagePath,
                height: 20.h,
                width: 20.w,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        labelText: labelText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.w,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
          borderSide: BorderSide(
            color: Colors.black54,
            width: 2.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.w,
          ),
        ),
      ),
    );
  }
}
