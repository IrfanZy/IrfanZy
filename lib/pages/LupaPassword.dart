import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/pages/Daftar.dart';
import 'package:quick_letter_1/pages/Login.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/services/Theme.dart';
import 'package:quick_letter_1/widgets/AlertNotification.dart';

class LupaPasword extends StatefulWidget {
  const LupaPasword({Key? key}) : super(key: key);

  @override
  State<LupaPasword> createState() => _LupaPaswordState();
}

class _LupaPaswordState extends State<LupaPasword> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController emailController = TextEditingController();

  bool isSendEmailProcess = false;

  sendPasswordReset(List<UserWarga> listWarga) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!isSendEmailProcess) {
      setState(() => isSendEmailProcess = true);

      String emailVerified = listWarga
          .firstWhere(
            (_) => _.email == emailController.text,
            orElse: () => UserWarga.empty,
          )
          .email;

      if (emailVerified.isNotEmpty) {
        try {
          await auth.sendPasswordResetEmail(email: emailVerified);
          AlertNotification(
            context: context,
            type: "success",
            width: 882,
            aspectRatio: 882 / 95,
            flexContentVertical: 38,
            flexTextHorizontal: 882 - 115,
            textContent: "Link reset password telah terkirim melalui email",
            nextAction: () {
              setState(() => isSendEmailProcess = false);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiProvider(
                    providers: [
                      StreamProvider<List<UserWarga>>.value(
                        value: firestoreService.listUserWarga(),
                        initialData: const [],
                        catchError: (context, object) => [],
                      ),
                    ],
                    child: const LoginPage(),
                  ),
                ),
                (route) => false,
              );
            },
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == "invalid-email") {
            AlertNotification(
              context: context,
              type: "warning",
              width: 699,
              aspectRatio: 699 / 95,
              flexContentVertical: 38,
              flexTextHorizontal: 699 - 115,
              textContent: "Terdapat kesalahan pada email terdaftar",
              nextAction: () {
                setState(() => isSendEmailProcess = false);
              },
            );
          } else if (e.code == "auth/user-not-found") {
            AlertNotification(
              context: context,
              type: "warning",
              width: 496,
              aspectRatio: 430 / 95,
              flexContentVertical: 38,
              flexTextHorizontal: 315,
              textContent: "Pengguna tidak ditemukan",
              nextAction: () {
                setState(() => isSendEmailProcess = false);
              },
            );
          } else {
            AlertNotification(
              context: context,
              type: "warning",
              width: 697,
              aspectRatio: 697 / 95,
              flexContentVertical: 38,
              flexTextHorizontal: 697 - 115,
              textContent: "Terjadi kesalahan, silahkan coba kembali",
              nextAction: () {
                setState(() => isSendEmailProcess = false);
              },
            );
          }
        } catch (e) {
          AlertNotification(
            context: context,
            type: "warning",
            width: 697,
            aspectRatio: 697 / 95,
            flexContentVertical: 38,
            flexTextHorizontal: 697 - 115,
            textContent: "Terjadi kesalahan, silahkan coba kembali",
            nextAction: () {
              setState(() => isSendEmailProcess = false);
            },
          );
        }
      } else {
        AlertNotification(
          context: context,
          type: "warning",
          width: 496,
          aspectRatio: 496 / 95,
          flexContentVertical: 38,
          flexTextHorizontal: 496 - 115,
          textContent: "Pengguna tidak ditemukan",
          nextAction: () {
            setState(() => isSendEmailProcess = false);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<UserWarga> listWarga = (Provider.of<List<UserWarga>>(context));

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            width: ThemeService.getWidth(context),
            height: ThemeService.getHeight(context) +
                MediaQuery.of(context).padding.top,
            child: Stack(
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 120,
                      horizontal: 20,
                    ),
                    constraints: BoxConstraints(
                      minHeight: ThemeService.getHeight(context) +
                          MediaQuery.of(context).padding.top,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        TextField(
                          controller: emailController,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
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
                              color: Colors.black38,
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
                          color: const Color(0xff3FBDF1),
                          elevation: 5,
                          child: SizedBox(
                            height: 65,
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () => sendPasswordReset(listWarga),
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
                        const SizedBox(height: 35),
                        const Text(
                          "Belum punya akun ?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
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
                          child: SizedBox(
                            height: 65,
                            child: InkWell(
                              splashColor: const Color(0xff3FBDF1),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MultiProvider(
                                      providers: [
                                        StreamProvider<List<UserWarga>>.value(
                                          value:
                                              firestoreService.listUserWarga(),
                                          initialData: const [],
                                          catchError: (context, object) => [],
                                        ),
                                      ],
                                      child: const DaftarPage(),
                                    ),
                                  ),
                                );
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
