import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

extension GetSizedbox on int {
  SizedBox getH() {
    return SizedBox(
      height: (this / 896) * height,
    );
  }

  SizedBox getW() {
    return SizedBox(
      width: (this / 414) * width,
    );
  }
}
