import "package:firebase_core/firebase_core.dart";
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import "package:permission_handler/permission_handler.dart";
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import "package:quick_letter_1/pages/Home.dart";
import 'package:quick_letter_1/pages/SplashScreen.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import "firebase_options.dart";
import "package:flutter/material.dart";
import "package:quick_letter_1/pages/LandingPage.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await [
    Permission.storage,
  ].request();
  runApp(App());
}

class App extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: FutureSplash.instance.initialize(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const SplashScreen()
              : FutureBuilder<Box>(
                  future: Hive.openBox("session"),
                  builder: (_, __) {
                    if (__.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: Colors.white,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    } else if (__.data != null) {
                      switch (__.data!.get("role").toString()) {
                        case "warga":
                          return MultiProvider(
                            providers: [
                              StreamProvider<UserWarga>.value(
                                value: firestoreService.userWarga(
                                  __.data!.get("id").toString(),
                                ),
                                initialData: UserWarga.empty,
                                catchError: (context, object) =>
                                    UserWarga.empty,
                              ),
                            ],
                            child: const Beranda(role: "warga"),
                          );

                        case "pengurus":
                        case "admin":
                          return MultiProvider(
                            providers: [
                              StreamProvider<UserPengurus>.value(
                                value: firestoreService.userPengurus(
                                  __.data!.get("id").toString(),
                                ),
                                initialData: UserPengurus.empty,
                                catchError: (context, object) =>
                                    UserPengurus.empty,
                              ),
                            ],
                            child: Beranda(
                              role: __.data!.get("role").toString(),
                            ),
                          );

                        default:
                          return const LandingPage();
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
        },
      ),
    );
  }
}
