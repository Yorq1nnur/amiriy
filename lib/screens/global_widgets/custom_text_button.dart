import 'package:flutter/material.dart';
import '../../utils/colors/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.text,
    required this.onTab,
    this.active,
  });

  final double height;
  final double width;
  final Color color;
  final String text;
  final VoidCallback onTab;
  final bool? active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.toDouble(),
      width: width.toDouble(),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: active != null && active!
              ? const WidgetStatePropertyAll(Colors.grey)
              : WidgetStatePropertyAll(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        onPressed: onTab,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: AppColors.white, fontSize: 14),
        ),
      ),
    );
  }
}
