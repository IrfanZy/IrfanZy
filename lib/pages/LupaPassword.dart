import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quick_letter_1/pages/Daftar.dart';

class LupaPasword extends StatefulWidget {
  const LupaPasword({Key? key}) : super(key: key);

  @override
  State<LupaPasword> createState() => _LupaPaswordState();
}

class _LupaPaswordState extends State<LupaPasword> {
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
              padding: EdgeInsets.fromLTRB(15, 120, 15, 120),
              child: Column(
                children: [
                  const Text(
                    "Lupa Password",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Silahkan masukan email anda.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff3FBDF1),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff3FBDF1),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      hintText: 'example@gmail.com',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color(0xff3FBDF1),
                    elevation: 5,
                    child: Container(
                      height: 65,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {},
                        child: const Center(
                          child: Text(
                            "Kirim",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  const Text(
                    "Belum punya akun ?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color(0xff3FBDF1),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      height: 65,
                      child: InkWell(
                        splashColor: Color(0xff3FBDF1),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DaftarPage()));
                        },
                        child: const Center(
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff3FBDF1),
                            ),
                          ),
                        ),
                      ),
                    ),
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
