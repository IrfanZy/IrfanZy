import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
        title: Text("my apps"),
      )),
    );
  }
}
