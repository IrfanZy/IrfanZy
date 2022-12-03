import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_letter_1/pages/Login.dart';

class Kepengurusan extends StatefulWidget {
  const Kepengurusan({Key? key}) : super(key: key);

  @override
  State<Kepengurusan> createState() => _KepengurusanState();
}

class _KepengurusanState extends State<Kepengurusan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Image(
                image: AssetImage('images/circleatas.png'),
              ),
            ),
            Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_SftL8OC48W.json',
              width: 300,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 75),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'LOGIN ',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          minimumSize: Size(30, 30),
                          primary: const Color(0xff242423),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("Warga"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Masukan PIN',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
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
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30,
                        ),
                        hintText: 'example (1234)',
                        hintStyle: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xff3FBDF1),
                    elevation: 5,
                    child: Container(
                      height: 50,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {},
                        child: const Center(
                          child: Text(
                            "Masuk",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
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
