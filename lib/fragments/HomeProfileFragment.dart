// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/pages/UbahPassword.dart';
import 'package:quick_letter_1/widgets/TextFieldCustomProfile.dart';

class HomeProfileFragment extends StatefulWidget {
  const HomeProfileFragment({super.key});

  @override
  State<HomeProfileFragment> createState() => _HomeProfileFragmentState();
}

class _HomeProfileFragmentState extends State<HomeProfileFragment> {
  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            const Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Image(
                  image: AssetImage('images/backgroundimage1.png'),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 110),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profilemu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      readOnly
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() => readOnly = !readOnly);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                minimumSize: const Size(30, 30),
                                backgroundColor: const Color(0xff242423),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text('Edit'),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(1000),
                              ),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(1000),
                                )),
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Ubah Foto Profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        'Nama',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Textfieldcustomprofile(
                    filled: true,
                    hint: 'Nama Lengkap',
                    readOnly: readOnly,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        'No.KK',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldcustomprofile(
                    filled: true,
                    hint: 'No. KK',
                    readOnly: readOnly,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        'NIK',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldcustomprofile(
                    filled: true,
                    hint: 'NIK',
                    readOnly: readOnly,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        'No. Telepon',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldcustomprofile(
                    filled: true,
                    hint: 'No. Telepon',
                    readOnly: readOnly,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldcustomprofile(
                    filled: true,
                    hint: 'Jenis Kelamin',
                    readOnly: readOnly,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Alamat',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldcustomprofile(
                    filled: true,
                    hint: 'Alamat',
                    readOnly: readOnly,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldcustomprofile(
                    filled: true,
                    hint: 'Email',
                    readOnly: readOnly,
                  ),
                  const SizedBox(
                    height: 15,
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
                          setState(() {
                            readOnly = true;
                          });
                        },
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
    );
  }
}
