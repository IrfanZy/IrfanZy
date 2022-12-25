// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/warga_model.dart';
import 'package:quick_letter_1/services/firestore.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final FirestoreService firestoreService = FirestoreService();
  TextEditingController nameController = TextEditingController(),
      nikController = TextEditingController(),
      addressController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<WargaModel> listWarga = (Provider.of<List<WargaModel>>(context));

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AssetImage("images/circleatas.png"),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
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
                        const SizedBox(
                          height: 18,
                        ),
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
                                Icons.person,
                                size: 30,
                              ),
                              hintText: 'Nama Lengkap',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 18,
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
                                Icons.email,
                                size: 30,
                              ),
                              hintText: 'NIK',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
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
                                Icons.home,
                                size: 30,
                              ),
                              hintText: 'Alamat',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        TextField(
                          controller: phoneNumberController,
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
                                Icons.phone,
                                size: 30,
                              ),
                              hintText: 'No. Telepon',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                Icons.lock,
                                size: 30,
                              ),
                              hintText: 'Password',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                  if (listWarga.any((warga) =>
                                      nikController.text == warga.nik)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "NIK telah terpakai",
                                        ),
                                      ),
                                    );
                                  } else {
                                    try {
                                      firestoreService
                                          .collection('warga')
                                          .add(
                                            WargaModel(
                                              name: nameController.text,
                                              nik: nikController.text,
                                              password: passwordController.text,
                                              address: addressController.text,
                                              phoneNumber:
                                                  phoneNumberController.text,
                                            ).toJson(),
                                          )
                                          .then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "Pendaftaran berhasil",
                                                    ),
                                                  ),
                                                )
                                              });
                                    } catch (e) {
                                      e.toString();
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Isian ada yang kosong",
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
              const Align(
                alignment: Alignment.bottomLeft,
                child: Image(
                  image: AssetImage("images/circle.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
