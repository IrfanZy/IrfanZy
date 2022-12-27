import 'package:flutter/material.dart';
import 'package:quick_letter_1/services/Theme.dart';

class DialogAction extends StatelessWidget {
  final BuildContext context;
  final bool isActive;
  final Column child;
  final Function() closeAction;
  final String title;

  const DialogAction({
    Key? key,
    required this.context,
    required this.isActive,
    required this.child,
    required this.closeAction,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getSize(double size) =>
        ThemeService.getSizeConstraint(context, size);

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: isActive
              ? SizedBox(
                  key: const ValueKey<int>(1),
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
                    color: const Color(0x66000000),
                  ),
                )
              : const SizedBox(key: ValueKey<int>(0), width: 0, height: 0),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: isActive
              ? Center(
                  key: const ValueKey<int>(1),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(75),
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: getSize(300),
                                  maxHeight: ThemeService.getHeight(context) -
                                      getSize(420),
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      getSize(30),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                      top: getSize(180),
                                      left: getSize(75),
                                      right: getSize(75),
                                      bottom: getSize(75),
                                    ),
                                    child: child,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              top: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 12,
                              top: 12,
                              child: SizedBox(
                                width: getSize(100),
                                height: getSize(100),
                                child: IconButton(
                                  onPressed: closeAction,
                                  padding: const EdgeInsets.all(0),
                                  splashRadius: 1,
                                  icon: const Icon(Icons.close_rounded),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(key: ValueKey<int>(0), width: 0, height: 0),
        ),
      ],
    );
  }
}
