import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserAdmin.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/pages/Daftar.dart';
import 'package:quick_letter_1/pages/Home.dart';
import 'package:quick_letter_1/pages/LoginPengurus.dart';
import 'package:quick_letter_1/pages/LupaPassword.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/widgets/AlertNotification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  bool isLoginProcess = false;
  TextEditingController nikController = TextEditingController(),
      passwordController = TextEditingController();

  void loginAccount(UserWarga user) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        AlertNotification(
          context: context,
          type: "success",
          aspectRatio: 430 / 95,
          width: 430,
          textContent: "Berhasil login akun",
          flexContentVertical: 38,
          flexTextHorizontal: 315,
          textAlign: TextAlign.start,
          nextAction: () {
            Hive.openBox('session').then(
              (_) {
                _.putAll({
                  "id": user.id,
                  "role": "warga",
                });
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        StreamProvider<UserWarga>.value(
                          value: firestoreService.userWarga(user.id),
                          initialData: UserWarga.empty,
                          catchError: (context, object) => UserWarga.empty,
                        ),
                      ],
                      child: const Beranda(role: "warga"),
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            );
          },
        );
      } else {
        throw Error;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        AlertNotification(
          aspectRatio: 697 / 95,
          flexContentVertical: 38,
          flexTextHorizontal: 582,
          textAlign: TextAlign.start,
          context: context,
          type: "error",
          width: 602,
          textContent: "Password yang dimasukkan salah",
          textMaxLines: 1,
          nextAction: () => setState(() => isLoginProcess = false),
        );
      } else {
        AlertNotification(
          aspectRatio: 697 / 95,
          flexContentVertical: 38,
          flexTextHorizontal: 582,
          textAlign: TextAlign.start,
          context: context,
          type: "warning",
          width: 697,
          textContent: "Terjadi kesalahan, silahkan coba kembali",
          textMaxLines: 1,
          nextAction: () => setState(() => isLoginProcess = false),
        );
      }
    } catch (e) {
      AlertNotification(
        aspectRatio: 697 / 95,
        flexContentVertical: 38,
        flexTextHorizontal: 582,
        textAlign: TextAlign.start,
        context: context,
        type: "warning",
        width: 697,
        textContent: "Terjadi kesalahan, silahkan coba kembali",
        textMaxLines: 1,
        nextAction: () => setState(() => isLoginProcess = false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<UserWarga> listUserWarga = (Provider.of<List<UserWarga>>(context));

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Image(
                image: AssetImage("assets/image/CircleAtasKiri.png"),
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Image(
                image: AssetImage("assets/image/CircleBawahKanan.png"),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 70, 20, 50),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MultiProvider(
                                          providers: [
                                            StreamProvider<
                                                List<UserAdmin>>.value(
                                              value: firestoreService
                                                  .listUserAdmin(),
                                              initialData: const [],
                                              catchError: (context, object) =>
                                                  [],
                                            ),
                                            StreamProvider<
                                                List<UserPengurus>>.value(
                                              value: firestoreService
                                                  .listUserPengurus(),
                                              initialData: const [],
                                              catchError: (context, object) =>
                                                  [],
                                            ),
                                          ],
                                          child: const Kepengurusan(),
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    minimumSize: const Size(30, 30),
                                    backgroundColor: const Color(0xff242423),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Text("Pengurus"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Selamat Datang Kembali, Silahkan Masuk Dengan Akun Anda.',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextField(
                              controller: nikController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                  hintText: 'NIK',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: false,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 30,
                                  ),
                                  hintText: 'Password',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LupaPasword(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Lupa Password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: const Color(0xff3FBDF1),
                              elevation: 5,
                              child: SizedBox(
                                height: 50,
                                child: InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (!isLoginProcess) {
                                      if (nikController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty) {
                                        setState(() => isLoginProcess = true);
                                        UserWarga user =
                                            listUserWarga.firstWhere(
                                          (_) => _.nik == nikController.text,
                                          orElse: () => UserWarga.empty,
                                        );

                                        if (user.id.isNotEmpty) {
                                          loginAccount(user);
                                        } else {
                                          AlertNotification(
                                            context: context,
                                            type: "error",
                                            aspectRatio: 727 / 95,
                                            width: 727,
                                            textAlign: TextAlign.start,
                                            textContent:
                                                "NIK yang dimasukkan tidak ditemukan",
                                            flexContentVertical: 38,
                                            flexTextHorizontal: 612,
                                            nextAction: () => setState(
                                              () => isLoginProcess = false,
                                            ),
                                          );
                                        }
                                      } else {
                                        AlertNotification(
                                          context: context,
                                          type: "warning",
                                          aspectRatio: 660 / 95,
                                          width: 660,
                                          textAlign: TextAlign.start,
                                          textContent:
                                              "Silahkan isi formulir dengan benar",
                                          flexContentVertical: 38,
                                          flexTextHorizontal: 545,
                                          nextAction: () => setState(
                                            () => isLoginProcess = false,
                                          ),
                                        );
                                      }
                                    }
                                  },
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
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Belum Punya Akun ?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
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
                                    );
                                  },
                                  child: const Text(
                                    "Daftar",
                                    style: TextStyle(
                                        color: Color(
                                      0xff3FBDF1,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
