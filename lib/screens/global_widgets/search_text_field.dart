import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.textEditingController,
    required this.valueChanged,
  });

  final TextEditingController textEditingController;
  final ValueChanged<String> valueChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: textEditingController,
        onChanged: valueChanged,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            size: 30.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.w,
            ),
          ),
        ),
      ),
    );
  }
}
