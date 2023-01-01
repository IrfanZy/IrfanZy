import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/pages/Login.dart';
import 'package:quick_letter_1/pages/UbahPassword.dart';
import 'package:quick_letter_1/pages/UbahPin.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/widgets/TextFieldCustomProfile.dart';

class HomeProfileFragment extends StatefulWidget {
  final String role;
  final Map<String, dynamic> user;

  const HomeProfileFragment({
    super.key,
    required this.role,
    required this.user,
  });

  @override
  State<HomeProfileFragment> createState() => _HomeProfileFragmentState();
}

class _HomeProfileFragmentState extends State<HomeProfileFragment> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final Map<String, Map<String, dynamic>> controllers =
      Map<String, Map<String, dynamic>>.from({});

  bool readOnly = true, isLogoutProcess = false, isUpdateProcess = false;

  @override
  Widget build(BuildContext context) {
    if (controllers.isEmpty) {
      if (widget.role == "pengurus") {
        controllers.addAll({
          "name": {
            "label": "Nama",
            "controller": TextEditingController(text: widget.user["name"]),
          },
          "position": {
            "label": "Jabatan",
            "controller": TextEditingController(text: widget.user["position"]),
          },
        });
      } else {
        controllers.addAll({
          "name": {
            "label": "Nama",
            "controller": TextEditingController(text: widget.user["name"]),
          },
          "nik": {
            "label": "NIK",
            "controller": TextEditingController(text: widget.user["nik"]),
          },
          "email": {
            "label": "Email",
            "controller": TextEditingController(text: widget.user["email"]),
          },
          "address": {
            "label": "Alamat",
            "controller": TextEditingController(text: widget.user["address"]),
          },
          "phoneNumber": {
            "label": "No. Telepon",
            "controller":
                TextEditingController(text: widget.user["phoneNumber"]),
          },
        });
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            const Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Image(
                  image: AssetImage('assets/image/BackgroundImage.png'),
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
                      Opacity(
                        opacity: readOnly ? 1 : 0,
                        child: ElevatedButton(
                          onPressed: readOnly
                              ? () => setState(() => readOnly = false)
                              : null,
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(30, 30),
                            backgroundColor: const Color(0xff242423),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('Edit'),
                        ),
                      ),
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
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child,
                                    Animation<double> animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: !readOnly
                                ? GestureDetector(
                                    onTap: () {
                                      //
                                    },
                                    child: Container(
                                      key: const ValueKey<bool>(true),
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(1000),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add_photo_alternate_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...controllers.keys
                      .map(
                        (_) => Column(
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  controllers[_]!["label"].toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextFieldCustomProfile(
                              controller: (controllers[_]!["controller"]
                                  as TextEditingController),
                              filled: true,
                              readOnly:
                                  readOnly || (_ == "nik" || _ == "email"),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 30),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(scale: animation, child: child),
                    child: !readOnly
                        ? Card(
                            key: const ValueKey<bool>(true),
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
                                  if (!isUpdateProcess &&
                                      controllers.keys.every((_) =>
                                          (controllers[_]!["controller"]
                                                  as TextEditingController)
                                              .text
                                              .isNotEmpty)) {
                                    setState(() => isUpdateProcess = true);
                                    if (widget.role == "warga") {
                                      firestoreService.updateUserWarga(
                                          id: widget.user["id"] ?? "",
                                          data: {
                                            "name": controllers["name"]![
                                                    "controller"]!
                                                .text,
                                            "address": controllers["address"]![
                                                    "controller"]!
                                                .text,
                                            "phoneNumber":
                                                controllers["phoneNumber"]![
                                                        "controller"]!
                                                    .text,
                                          },
                                          onSuccess: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Berhasil memperbarui profil",
                                                ),
                                              ),
                                            );
                                            setState(
                                              () {
                                                isUpdateProcess = false;
                                                readOnly = true;
                                              },
                                            );
                                          },
                                          onError: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Terjadi kesalahan, gagal memperbarui profil",
                                                ),
                                              ),
                                            );
                                            setState(
                                              () => isUpdateProcess = false,
                                            );
                                          });
                                    } else {
                                      firestoreService.updateUserPengurus(
                                          id: widget.user["id"] ?? "",
                                          data: {
                                            "name": controllers["name"]![
                                                    "controller"]!
                                                .text,
                                            "position": controllers[
                                                    "position"]!["controller"]!
                                                .text,
                                          },
                                          onSuccess: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Berhasil memperbarui profil",
                                                ),
                                              ),
                                            );
                                            setState(
                                              () {
                                                isUpdateProcess = false;
                                                readOnly = true;
                                              },
                                            );
                                          },
                                          onError: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Terjadi kesalahan, gagal memperbarui profil",
                                                ),
                                              ),
                                            );
                                            setState(
                                              () => isUpdateProcess = false,
                                            );
                                          });
                                    }
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    "Simpan",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(
                            key: ValueKey<bool>(false),
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
                          if (widget.role == "pengurus") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MultiProvider(
                                  providers: [
                                    StreamProvider<UserPengurus>.value(
                                      value: firestoreService.userPengurus(
                                        widget.user["id"] ?? "",
                                      ),
                                      initialData: UserPengurus.empty,
                                      catchError: (context, object) =>
                                          UserPengurus.empty,
                                    ),
                                  ],
                                  child: const ChangePin(),
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MultiProvider(
                                  providers: [
                                    StreamProvider<UserWarga>.value(
                                      value: firestoreService.userWarga(
                                        widget.user["id"] ?? "",
                                      ),
                                      initialData: UserWarga.empty,
                                      catchError: (context, object) =>
                                          UserWarga.empty,
                                    ),
                                  ],
                                  child: const ChangePassword(),
                                ),
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            widget.role == "pengurus"
                                ? "Ubah PIN"
                                : "Ubah Password",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color.fromARGB(255, 250, 73, 73),
                    elevation: 5,
                    child: SizedBox(
                      height: 50,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
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
                                            builder: (context) => MultiProvider(
                                              providers: [
                                                StreamProvider<
                                                    List<UserWarga>>.value(
                                                  value: firestoreService
                                                      .listUserWarga(),
                                                  initialData: const [],
                                                  catchError:
                                                      (context, object) => [],
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
                        },
                        child: const Center(
                          child: Text(
                            " Log Out",
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
