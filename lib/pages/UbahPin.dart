import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/widgets/TextFieldCustomProfile.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController oldPinController = TextEditingController(),
      newPinController = TextEditingController(),
      newPinController2 = TextEditingController();

  bool isChangePinProcess = false;

  @override
  Widget build(BuildContext context) {
    UserPengurus user = Provider.of<UserPengurus>(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: const [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image(
                      image: AssetImage('assets/image/CircleAtas.png'),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Image(
                    height: 200,
                    image: AssetImage(
                      'assets/image/UbahPassword.png',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 55),
                    child: Column(
                      children: [
                        const Text(
                          "Ubah Pin Baru",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "PIN yang baru harus berbeda dengan PIN yang digunakan sebelumnya.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustomProfile(
                          controller: oldPinController,
                          hint: 'Pin Lama',
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustomProfile(
                          controller: newPinController,
                          hint: 'Pin Baru',
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustomProfile(
                          controller: newPinController2,
                          hint: 'Konfirmasi Pin',
                        ),
                        const SizedBox(height: 20),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: const Color(0xff3FBDF1),
                          elevation: 5,
                          child: SizedBox(
                            height: 60,
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () async {
                                if (!isChangePinProcess &&
                                    oldPinController.text.isNotEmpty &&
                                    newPinController.text.isNotEmpty &&
                                    newPinController2.text.isNotEmpty) {
                                  if (newPinController.text ==
                                          newPinController2.text &&
                                      oldPinController.text == user.pin &&
                                      newPinController.text != user.pin) {
                                    if ((await firestoreService
                                                    .collection("user_pengurus")
                                                    .where(
                                                      "pin",
                                                      isEqualTo:
                                                          newPinController.text,
                                                    )
                                                    .get())
                                                .size ==
                                            0 &&
                                        (await firestoreService
                                                    .collection("user_admin")
                                                    .where(
                                                      "pin",
                                                      isEqualTo:
                                                          newPinController.text,
                                                    )
                                                    .get())
                                                .size ==
                                            0) {
                                      firestoreService.updateUserPengurus(
                                          id: user.id,
                                          data: {"pin": newPinController.text},
                                          onSuccess: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Berhasil memperbarui PIN",
                                                ),
                                              ),
                                            );
                                            setState(
                                              () => isChangePinProcess = false,
                                            );
                                            oldPinController.clear();
                                            newPinController.clear();
                                            newPinController2.clear();
                                          },
                                          onError: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Gagal memperbarui PIN, silahkan coba kembali",
                                                ),
                                              ),
                                            );
                                            setState(
                                              () => isChangePinProcess = false,
                                            );
                                          });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "PIN telah digunakan pada akun lain",
                                          ),
                                        ),
                                      );
                                      setState(
                                        () => isChangePinProcess = false,
                                      );
                                    }
                                  } else if (newPinController.text !=
                                      newPinController2.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "PIN baru yang dimasukkan tidak cocok",
                                        ),
                                      ),
                                    );
                                    setState(() => isChangePinProcess = false);
                                  } else if (oldPinController.text !=
                                      user.pin) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "PIN lama yang dimasukkan salah",
                                        ),
                                      ),
                                    );
                                    setState(
                                      () => isChangePinProcess = false,
                                    );
                                  } else if (newPinController.text ==
                                      user.pin) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "PIN baru harus berbeda dari PIN sebelumnya",
                                        ),
                                      ),
                                    );
                                    setState(
                                      () => isChangePinProcess = false,
                                    );
                                  }
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Ganti Pin",
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
