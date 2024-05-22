import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GlobalText extends StatelessWidget {
  const GlobalText({
    super.key,
    required this.data,
    this.color,
    required this.fontSize,
    required this.fontWeight,
    this.maxLines,
    this.textAlign,
    required this.isTranslate,
  });

  final String data;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isTranslate;

  @override
  Widget build(BuildContext context) {
    return Text(
      isTranslate ? data.tr() : data,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? Theme.of(context).textTheme.bodySmall?.color,
          ),
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 10,
    );
  }
}
