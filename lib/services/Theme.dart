import 'package:flutter/material.dart';

class ThemeService {
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

  static double getSizeConstraint(BuildContext context, double value) =>
      getWidth(context) * (value / 1080);

  static const Color alertColorSuccess = Color(0xFF43A047);
  static const Color alertColorError = Color(0xFFB00020);
  static const Color alertColorWarning = Color(0xFFFFA000);
  static const Color alertColorInfo = Color(0xFF1976D2);
}
