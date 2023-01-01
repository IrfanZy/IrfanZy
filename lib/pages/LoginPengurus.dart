import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserAdmin.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/pages/Home.dart';
import 'package:quick_letter_1/pages/Login.dart';
import 'package:quick_letter_1/services/Firestore.dart';

class Kepengurusan extends StatefulWidget {
  const Kepengurusan({Key? key}) : super(key: key);

  @override
  State<Kepengurusan> createState() => _KepengurusanState();
}

class _KepengurusanState extends State<Kepengurusan> {
  final FirestoreService firestoreService = FirestoreService();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<UserAdmin> listUserAdmin = Provider.of<List<UserAdmin>>(context);
    List<UserPengurus> listUserPengurus = Provider.of<List<UserPengurus>>(
      context,
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Image(
                image: AssetImage('assets/image/CircleAtas.png'),
              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Image(
                image: AssetImage("assets/image/Circle.png"),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/animation/LottiePin.json',
                        width: 300,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 75),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'LOGIN ',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => MultiProvider(
                                        providers: [
                                          StreamProvider<List<UserWarga>>.value(
                                            value: firestoreService
                                                .listUserWarga(),
                                            initialData: const [],
                                            catchError: (context, object) => [],
                                          ),
                                        ],
                                        child: const LoginPage(),
                                      ),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    minimumSize: const Size(30, 30),
                                    backgroundColor: const Color(0xff242423),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Text("Warga"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Masukan PIN',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller,
                              obscureText: true,
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
                                  hintText: ' Example (1234)',
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
                                height: 50,
                                width: 250,
                                child: InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    if (listUserAdmin.any(
                                          (_) => _.pin == controller.text,
                                        ) &&
                                        listUserPengurus.any(
                                          (_) => _.pin == controller.text,
                                        )) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "PIN yang dimasukkan tidak valid",
                                          ),
                                        ),
                                      );
                                    } else {
                                      Hive.openBox('session').then(
                                        (_) {
                                          _.putAll(
                                            {
                                              'id': listUserAdmin.any(
                                                (_) => _.pin == controller.text,
                                              )
                                                  ? listUserAdmin
                                                      .firstWhere(
                                                        (_) =>
                                                            _.pin ==
                                                            controller.text,
                                                        orElse: () =>
                                                            UserAdmin.empty,
                                                      )
                                                      .id
                                                  : listUserPengurus
                                                      .firstWhere(
                                                        (_) =>
                                                            _.pin ==
                                                            controller.text,
                                                        orElse: () =>
                                                            UserPengurus.empty,
                                                      )
                                                      .id,
                                              'role': listUserAdmin.any(
                                                (_) => _.pin == controller.text,
                                              )
                                                  ? "admin"
                                                  : "pengurus",
                                            },
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Berhasil login akun",
                                              ),
                                            ),
                                          );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(
                                                providers: [
                                                  _.get('role') == "pengurus"
                                                      ? StreamProvider<
                                                          UserPengurus>.value(
                                                          value:
                                                              firestoreService
                                                                  .userPengurus(
                                                            listUserPengurus
                                                                .firstWhere(
                                                                  (_) =>
                                                                      _.pin ==
                                                                      controller
                                                                          .text,
                                                                  orElse: () =>
                                                                      UserPengurus
                                                                          .empty,
                                                                )
                                                                .id,
                                                          ),
                                                          initialData:
                                                              UserPengurus
                                                                  .empty,
                                                          catchError: (context,
                                                                  object) =>
                                                              UserPengurus
                                                                  .empty,
                                                        )
                                                      : StreamProvider<
                                                          UserAdmin>.value(
                                                          value:
                                                              firestoreService
                                                                  .userAdmin(
                                                            listUserAdmin
                                                                .firstWhere(
                                                                  (_) =>
                                                                      _.pin ==
                                                                      controller
                                                                          .text,
                                                                  orElse: () =>
                                                                      UserAdmin
                                                                          .empty,
                                                                )
                                                                .id,
                                                          ),
                                                          initialData:
                                                              UserAdmin.empty,
                                                          catchError: (context,
                                                                  object) =>
                                                              UserAdmin.empty,
                                                        ),
                                                ],
                                                child: Beranda(
                                                  role: listUserPengurus.any(
                                                    (_) =>
                                                        _.pin ==
                                                        controller.text,
                                                  )
                                                      ? "pengurus"
                                                      : "admin",
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
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
            )
          ],
        ),
      ),
    );
  }
}
