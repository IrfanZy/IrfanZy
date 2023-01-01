import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/widgets/TextFieldCustomProfile.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController oldPasswordController = TextEditingController(),
      newPasswordController = TextEditingController(),
      newPasswordController2 = TextEditingController();

  UserWarga user = UserWarga.empty;
  bool isUpdateProcess = false;

  void handleChangePassword() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (newPasswordController.text.length >= 8 &&
        newPasswordController2.text.length >= 8) {
      if (!isUpdateProcess) {
        setState(() => isUpdateProcess = true);
        if (newPasswordController.text != newPasswordController2.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Password baru yang dimasukkan tidak cocok",
              ),
            ),
          );
          setState(() => isUpdateProcess = false);
        } else {
          try {
            UserCredential userCredential =
                await auth.currentUser!.reauthenticateWithCredential(
              EmailAuthProvider.credential(
                email: user.email,
                password: oldPasswordController.text,
              ),
            );

            if (userCredential.user != null) {
              await userCredential.user!.updatePassword(
                  newPasswordController.text.toString().replaceAll(' ', ''));

              oldPasswordController.clear();
              newPasswordController.clear();
              newPasswordController2.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Berhasil memperbarui password akun",
                  ),
                ),
              );
              setState(() => isUpdateProcess = false);
            } else {
              throw Error;
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == "wrong-password") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Password lama yang dimasukkan salah",
                  ),
                ),
              );
              setState(() => isUpdateProcess = false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Terjadi kesalahan, silahkan coba kembali",
                  ),
                ),
              );
              setState(() => isUpdateProcess = false);
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Terjadi kesalahan, silahkan coba kembali",
                ),
              ),
            );
            setState(() => isUpdateProcess = false);
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password harus terdiri dari minimal 8 karakter",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserWarga>(context);

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
                          "Ubah Password Baru",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Kata sandi yang baru harus berbeda dengan kata sandi yang sebelumnya.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustomProfile(
                          controller: oldPasswordController,
                          hint: 'Password Lama',
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustomProfile(
                          controller: newPasswordController,
                          hint: 'Password Baru',
                        ),
                        const SizedBox(height: 20),
                        TextFieldCustomProfile(
                          controller: newPasswordController2,
                          hint: 'Konfirmasi Password',
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
                              onTap: handleChangePassword,
                              child: const Center(
                                child: Text(
                                  "Ganti Password",
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
