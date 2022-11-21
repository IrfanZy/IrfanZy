// ignore_for_file: file_names

// import 'dart:html';
import 'dart:html';

import 'package:flutter/material.dart';

class EaxmplePage extends StatefulWidget {
  const EaxmplePage({super.key});

  @override
  State<EaxmplePage> createState() => _EaxmplePageState();
}

class _EaxmplePageState extends State<EaxmplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage("images/gambarbaru.png"),
              width: 300,
              height: 300,
            ),
            Column(
              children: [
                Text("Selamat Datang",
                    style: TextStyle(color: Colors.black, fontSize: 40)),
                Text(
                  "Silahkan Login Atau Daftar Sebelum Melanjutkan Kedalam Aplikasi",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 18.0)),
                    onPressed: () {},
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Daftar"),
                    style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        side: BorderSide(color: Colors.blue)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
