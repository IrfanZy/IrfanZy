import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/services/Theme.dart';
import 'package:quick_letter_1/widgets/AlertNotification.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  TextEditingController nameController = TextEditingController(),
      nikController = TextEditingController(),
      emailController = TextEditingController(),
      addressController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      passwordController = TextEditingController();

  void registerAccount() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(nameController.text);

        firestoreService
            .collection('user_warga')
            .doc(userCredential.user!.uid)
            .set(
              UserWarga.createNew(
                name: nameController.text,
                nik: nikController.text,
                email: emailController.text,
                address: addressController.text,
                phoneNumber: phoneNumberController.text,
              ),
            )
            .then((value) => AlertNotification(
                  aspectRatio: 697 / 95,
                  flexContentVertical: 38,
                  flexTextHorizontal: 582,
                  textAlign: TextAlign.start,
                  context: context,
                  type: "success",
                  width: 697,
                  textContent: "Berhasil melakukan pendaftaran akun",
                  textMaxLines: 1,
                  nextAction: () async {
                    nameController.clear();
                    nikController.clear();
                    emailController.clear();
                    addressController.clear();
                    phoneNumberController.clear();
                    passwordController.clear();
                    try {
                      await auth.signOut();
                    } on FirebaseAuthException catch (e) {
                      e.toString();
                    }
                  },
                ));
      } else {
        try {
          await auth.signOut();
        } on FirebaseAuthException catch (e) {
          e.toString();
        }

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
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        AlertNotification(
          aspectRatio: 831 / 95,
          flexContentVertical: 38,
          flexTextHorizontal: 831 - 115,
          textAlign: TextAlign.start,
          context: context,
          type: "warning",
          width: 831,
          textContent: "Password lemah, silahkan gunakan password lain",
          textMaxLines: 1,
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
        );
      }
    } catch (e) {
      e.toString();
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
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: ThemeService.getHeight(context),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "DAFTAR",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Silahkan isi form dibawah ini untuk mendaftar akun anda.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_rounded,
                                    size: 30,
                                  ),
                                  hintText: 'Nama Lengkap',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: nikController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.payment_rounded,
                                    size: 30,
                                  ),
                                  hintText: 'NIK',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_rounded,
                                    size: 30,
                                  ),
                                  hintText: 'Email',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: addressController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.home_rounded,
                                    size: 30,
                                  ),
                                  hintText: 'Alamat',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone_rounded,
                                    size: 30,
                                  ),
                                  hintText: 'No. Telepon',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff3FBDF1),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_rounded,
                                    size: 30,
                                  ),
                                  hintText: 'Password',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 18),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: const Color(0xff3FBDF1),
                              elevation: 5,
                              child: SizedBox(
                                height: 60,
                                child: InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    if (nameController.text.isNotEmpty &&
                                        nikController.text.isNotEmpty &&
                                        addressController.text.isNotEmpty &&
                                        phoneNumberController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty) {
                                      if (nikController.text.length < 16) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "NIK yang dimasukkan tidak valid",
                                            ),
                                          ),
                                        );
                                      } else if (listUserWarga.any((warga) =>
                                          nikController.text == warga.nik)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "NIK yang dimasukkan telah digunakan",
                                            ),
                                          ),
                                        );
                                      } else if (!EmailValidator.validate(
                                        emailController.text,
                                      )) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Email yang dimasukkan tidak valid",
                                            ),
                                          ),
                                        );
                                      } else if (listUserWarga.any((warga) =>
                                          emailController.text ==
                                          warga.email)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Email yang dimasukkan telah digunakan",
                                            ),
                                          ),
                                        );
                                      } else if (passwordController
                                              .text.length <
                                          8) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Password harus terdiri dari minimal 8 karakter",
                                            ),
                                          ),
                                        );
                                      } else {
                                        registerAccount();
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Silahkan periksa formulir dengan benar",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Sign Up",
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
