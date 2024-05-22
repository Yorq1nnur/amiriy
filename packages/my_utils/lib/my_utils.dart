double height = 0.0;
double width = 0.0;

extension SizeUtils on int {
  double get h => (this / 896) * height;

  double get w => (this / 414) * width;
  double get sp => (this / 414) * width;
}
