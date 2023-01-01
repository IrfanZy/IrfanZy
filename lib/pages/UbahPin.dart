import 'package:flutter/material.dart';
import 'package:quick_letter_1/widgets/TextFieldCustomProfile.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final TextEditingController oldPinController = TextEditingController(),
      newPinController = TextEditingController(),
      newPinController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          "PIN yang baru harus berbeda dengan kata sandi yang sebelumnya.",
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
                              onTap: () {},
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
