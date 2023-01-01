import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/pages/Login.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/widgets/DialogAction.dart';
import 'package:quick_letter_1/widgets/TextFieldCustom.dart';

class KelolaAdmin extends StatefulWidget {
  const KelolaAdmin({super.key});

  @override
  State<KelolaAdmin> createState() => _KelolaAdminState();
}

class _KelolaAdminState extends State<KelolaAdmin> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController controller = TextEditingController();
  bool visibleDialogAddData = false, isLogoutProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 5,
                      )
                    ]),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      right: 20,
                      left: 20,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 30),
                          const Expanded(
                            child: Text(
                              "Daftar Pengurus",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: const [
                                        Text(
                                          "Log Out",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.logout_rounded,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (int value) {
                              switch (value) {
                                case 1:
                                  if (!isLogoutProcess) {
                                    setState(() => isLogoutProcess = true);
                                    try {
                                      auth.signOut().whenComplete(
                                            () => Hive.openBox("session").then(
                                              (_) {
                                                _.deleteAll(['id', 'role']);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Akun Anda akan segera keluar,\nTerimakasih telah menggunakan Aplikasi ini"),
                                                  ),
                                                );
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MultiProvider(
                                                      providers: [
                                                        StreamProvider<
                                                            List<
                                                                UserWarga>>.value(
                                                          value: firestoreService
                                                              .listUserWarga(),
                                                          initialData: const [],
                                                          catchError: (context,
                                                                  object) =>
                                                              [],
                                                        ),
                                                      ],
                                                      child: const LoginPage(),
                                                    ),
                                                  ),
                                                  (route) => false,
                                                );
                                              },
                                            ),
                                          );
                                    } catch (e) {
                                      setState(() => isLogoutProcess = false);
                                    }
                                  }
                                  break;

                                default:
                                  break;
                              }
                            },
                            child: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 150,
              right: 50,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    visibleDialogAddData = true;
                  });
                },
                backgroundColor: const Color(0xff3FBDF1),
                child: const Icon(Icons.add),
              ),
            ),
            DialogAction(
              context: context,
              isActive: visibleDialogAddData,
              title: "Tambah Data Pengurus",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldCustom(
                    controller: controller,
                    hint: "Nama",
                  ),
                  const SizedBox(height: 20),
                  TextFieldCustom(
                    controller: controller,
                    hint: "Jabatan",
                  ),
                  const SizedBox(height: 20),
                  TextFieldCustom(
                    controller: controller,
                    hint: "Pin",
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      minimumSize: const Size(80, 45),
                      backgroundColor: const Color(0xff3FBDF1),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
              closeAction: () {
                setState(() {
                  visibleDialogAddData = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
