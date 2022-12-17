// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/widgets/TextFieldCustomProfile.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: const [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image(
                      image: AssetImage('images/circleatas.png'),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Image(
                    height: 200,
                    image: AssetImage(
                      'images/ubahpassword.png',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 55),
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
                        const Textfieldcustomprofile(
                          hint: 'Password Lama',
                        ),
                        const SizedBox(height: 20),
                        const Textfieldcustomprofile(
                          hint: 'Password Baru',
                        ),
                        const SizedBox(height: 20),
                        const Textfieldcustomprofile(
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
                              onTap: () {},
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
