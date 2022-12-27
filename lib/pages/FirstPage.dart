import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/pages/Daftar.dart';
import 'package:quick_letter_1/pages/Login.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/services/Theme.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Image(
              image: AssetImage("assets/image/CircleAtas.png"),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Image(
              image: AssetImage("assets/image/Circle.png"),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    constraints: BoxConstraints(
                      minHeight: ThemeService.getHeight(context),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/animation/LottieNewletters.json',
                          ),
                          const SizedBox(height: 20),
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
                                    backgroundColor: const Color(0xff3FBDF1),
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => MultiProvider(
                                          providers: [
                                            StreamProvider<
                                                List<UserWarga>>.value(
                                              value: firestoreService
                                                  .listUserWarga(),
                                              initialData: const [],
                                              catchError: (context, object) =>
                                                  [],
                                            ),
                                          ],
                                          child: const LoginPage(),
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => MultiProvider(
                                          providers: [
                                            StreamProvider<
                                                List<UserWarga>>.value(
                                              value: firestoreService
                                                  .listUserWarga(),
                                              initialData: const [],
                                              catchError: (context, object) =>
                                                  [],
                                            ),
                                          ],
                                          child: const DaftarPage(),
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  // ignore: sort_child_properties_last
                                  child: const Text(
                                    "Daftar",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
