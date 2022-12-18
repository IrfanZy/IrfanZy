// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Beranda extends StatefulWidget {
  final String role;
  final List<Widget> fragments;

  const Beranda({
    Key? key,
    required this.role,
    required this.fragments,
  }) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int indexTab = 0;

  @override
  Widget build(BuildContext context) {
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
                      return widget.fragments[0];

                    case 1:
                      return widget.fragments[1];

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
