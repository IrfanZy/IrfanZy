import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Row(
        children: const <Widget>[
          Spacer(flex: 150),
          Flexible(
            flex: 730,
            child: FlutterLogo(
              size: double.infinity,
              style: FlutterLogoStyle.horizontal,
              textColor: Colors.blueGrey,
            ),
          ),
          Spacer(flex: 200),
        ],
      )),
    );
  }
}

class FutureSplash {
  FutureSplash._();
  static final instance = FutureSplash._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 4));
  }
}
