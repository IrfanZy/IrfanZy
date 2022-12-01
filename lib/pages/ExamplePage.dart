// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/pages/Daftar.dart';
import 'package:quick_letter_1/pages/login.dart';

class EaxmplePage extends StatefulWidget {
  const EaxmplePage({super.key});

  @override
  State<EaxmplePage> createState() => _EaxmplePageState();
}

class _EaxmplePageState extends State<EaxmplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Image(
                image: AssetImage("images/circleatas.png"),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 70),
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("images/gambarbaru.png"),
                    width: 280,
                    height: 300,
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: const [
                      Text(
                        "Selamat Datang",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Silahkan Login Atau Daftar Sebelum Melanjutkan Kedalam Aplikasi",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff3FBDF1),
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const DaftarPage(),
                              ),
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                            side: const BorderSide(
                              color: Color(0xff3FBDF1),
                              width: 1.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Image(
                image: AssetImage("images/circle.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
