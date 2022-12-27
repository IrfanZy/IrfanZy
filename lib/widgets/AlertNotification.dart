import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_letter_1/services/Theme.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> AlertNotification({
  required BuildContext context,
  required String type,
  required double aspectRatio,
  required double width,
  required String textContent,
  required int flexContentVertical,
  required int flexTextHorizontal,
  int textMaxLines = 1,
  int duration = 3000,
  TextAlign textAlign = TextAlign.center,
  void Function()? nextAction,
}) {
  // ignore: prefer_function_declarations_over_variables
  double Function(double size) getSize =
      (double size) => ThemeService.getSizeConstraint(context, size);

  String iconPath;
  Color backgroundColor;

  switch (type) {
    case 'success':
      iconPath = "assets/svg/AlertSuccess.svg";
      backgroundColor = ThemeService.alertColorSuccess;
      break;

    case 'error':
      iconPath = "assets/svg/AlertError.svg";
      backgroundColor = ThemeService.alertColorError;
      break;

    case 'warning':
      iconPath = "assets/svg/AlertWarning.svg";
      backgroundColor = ThemeService.alertColorWarning;
      break;

    case 'info':
      iconPath = "assets/svg/AlertWarning.svg";
      backgroundColor = ThemeService.alertColorInfo;
      break;

    default:
      iconPath = "assets/svg/AlertError.svg";
      backgroundColor = ThemeService.alertColorError;
      break;
  }

  final alertContents = (type != "info")
      ? [
          const Spacer(flex: 24),
          Flexible(
            flex: flexContentVertical,
            child: Row(
              children: [
                const Spacer(flex: 25),
                Flexible(
                  flex: 40,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: SvgPicture.asset(
                      iconPath,
                      width: 30,
                    ),
                  ),
                ),
                const Spacer(flex: 20),
                Flexible(
                  flex: flexTextHorizontal,
                  child: Center(
                    child: AutoSizeText(
                      textContent,
                      maxLines: textMaxLines,
                      textAlign: textAlign,
                      style: const TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 25),
              ],
            ),
          ),
          const Spacer(flex: 24),
        ]
      : [
          const Spacer(flex: 30),
          Flexible(
            flex: flexContentVertical,
            child: Row(
              children: [
                const Spacer(flex: 30),
                Flexible(
                  flex: ((flexTextHorizontal / 2).round()) - 3,
                  child: Center(
                    child: AutoSizeText(
                      textContent.split("\n")[0],
                      textAlign: textAlign,
                      maxLines: 1,
                      minFontSize: 1,
                      style: const TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 30),
              ],
            ),
          ),
          const Spacer(flex: 6),
          Flexible(
            flex: flexContentVertical,
            child: Row(
              children: [
                const Spacer(flex: 30),
                Flexible(
                  flex: ((flexTextHorizontal / 2).round()) - 3,
                  child: Center(
                    child: AutoSizeText(
                      textContent.split("\n")[1],
                      textAlign: textAlign,
                      maxLines: 1,
                      minFontSize: 1,
                      style: const TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 30),
              ],
            ),
          ),
          const Spacer(flex: 30),
        ];

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: AspectRatio(
        aspectRatio: aspectRatio,
        child: Center(
          child: Column(
            children: alertContents,
          ),
        ),
      ),
      duration: Duration(milliseconds: duration),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
      backgroundColor: backgroundColor,
      width: getSize(width),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getSize(15)),
      ),
      onVisible: () {
        Timer(Duration(milliseconds: duration), nextAction ?? () {});
      },
    ),
  );
}
