import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/fragments/AdminFragment.dart';
import 'package:quick_letter_1/fragments/HomeBerandaFragment.dart';
import 'package:quick_letter_1/fragments/HomeProfileFragment.dart';
import 'package:quick_letter_1/models/UserAdmin.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/models/UserWarga.dart';
import 'package:quick_letter_1/services/Constant.dart';

class Beranda extends StatefulWidget {
  final String role;

  const Beranda({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int indexTab = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = widget.role == "pengurus"
        ? Provider.of<UserPengurus>(context).toJson()
        : widget.role == "admin"
            ? Provider.of<UserAdmin>(context).toJson()
            : Provider.of<UserWarga>(context).toJson();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                key: ValueKey<int>(indexTab),
                child: (() {
                  switch (indexTab) {
                    case 0:
                      return HomeBerandaFragment(
                        illustrationPath: widget.role == "warga"
                            ? "assets/image/FastPrint.png"
                            : "assets/image/ManageDataWarga.png",
                        title: widget.role == "warga"
                            ? "Cetak Surat Pengantar"
                            : "Kelola Data Warga",
                        description: widget.role == "warga"
                            ? "Warga dapat dengan mudah mencetak surat pengantar RT dengan menekan tombol dibawah ini"
                            : "Pengurus RT dan admin dapat mengkelola dan mengubah data setiap warga per-blok yang sudah tercantum di dalam form nya.",
                        features: widget.role == "warga"
                            ? Features.Warga
                            : Features.Pengurus,
                      );

                    case 1:
                      return widget.role == "admin"
                          ? KelolaAdmin(
                              listUserPengurus: Provider.of<List<UserPengurus>>(
                                context,
                              ),
                            )
                          : HomeProfileFragment(
                              role: widget.role,
                              user: user,
                            );

                    default:
                      return Container();
                  }
                })(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 15, 50, 15),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 30,
                    offset: const Offset(1, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: GNav(
                onTabChange: (value) => setState(() => indexTab = value),
                color: const Color(0xff3FBDF1),
                activeColor: const Color(0xff3FBDF1),
                haptic: true,
                tabBackgroundColor: const Color(0xff3FBDF1).withOpacity(.2),
                tabBorderRadius: 30,
                gap: 15,
                iconSize: 30,
                tabs: [
                  const GButton(
                    icon: Icons.home,
                    text: 'Beranda',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: widget.role == "admin" ? "Admin" : "Profile",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
