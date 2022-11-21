// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:quick_letter_1/pages/ExamplePage.dart';
import 'package:quick_letter_1/pages/LandingPage.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
