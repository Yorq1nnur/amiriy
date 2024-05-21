import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldContainer extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyBoardType;
  final String labelText;
  final Color labelTextColor;
  final ValueChanged<String> onChange;
  final TextStyle textStyle;
  final Widget? suffixIcon;
  final MaskTextInputFormatter? maskTextInputFormatter;
  final bool isObscureText;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  const TextFieldContainer({
    super.key,
    this.hintText = '',
    required this.keyBoardType,
    required this.controller,
    required this.onChange,
    this.labelText = '',
    this.labelTextColor = Colors.black,
    this.suffixIcon = const SizedBox(),
    this.textStyle = const TextStyle(),
    this.maskTextInputFormatter,
    this.isObscureText = false,
    this.focusNode,
    this.prefixIcon,
  });

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: widget.textStyle,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
              color: Colors.white24, borderRadius: BorderRadius.circular(12)),
          child: TextField(
            obscureText: obscure,
            focusNode: widget.focusNode,
            inputFormatters: widget.maskTextInputFormatter != null
                ? [widget.maskTextInputFormatter!]
                : null,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(obscure
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash),
                    )
                  : widget.suffixIcon,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            keyboardType: widget.keyBoardType,
            // maxLines: ,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
