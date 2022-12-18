// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ThemeService {
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

  static double getSizeConstraint(BuildContext context, double value) =>
      getWidth(context) * (value / 1080);
}
