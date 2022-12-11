import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quick_letter_1/pages/UbahPassword.dart';
import 'package:quick_letter_1/widgets/TextFieldCustom.dart';
import 'package:quick_letter_1/widgets/TextFieldCustomProfile.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: const [
                  Image(
                    image: AssetImage('images/backgroundimage1.png'),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 50, 25, 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Profilmu',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(30, 30),
                            backgroundColor: const Color(0xff242423),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Ubah Foto Profile',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    const Textfieldcustomprofile(
                      filled: true,
                      hint: 'Nama Lengkap',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Textfieldcustomprofile(
                      filled: true,
                      hint: 'No. KK',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Textfieldcustomprofile(
                      filled: true,
                      hint: 'NIK',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Textfieldcustomprofile(
                      filled: true,
                      hint: 'No. Telepon',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Textfieldcustomprofile(
                      filled: true,
                      hint: 'Jenis Kelamin',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Textfieldcustomprofile(
                      filled: true,
                      hint: 'Alamat',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Textfieldcustomprofile(
                      filled: true,
                      hint: 'Email',
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
                        height: 50,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () {},
                          child: const Center(
                            child: Text(
                              "Simpan",
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
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color(0xff3FBDF1),
                      elevation: 5,
                      child: SizedBox(
                        height: 50,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ChangePassword()));
                          },
                          child: const Center(
                            child: Text(
                              "Ubah Password",
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
    );
  }
}
