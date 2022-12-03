import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(50, 15, 50, 15),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 30,
              offset: Offset(1, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: GNav(
          color: Color(0xff3FBDF1),
          activeColor: Color(0xff3FBDF1),
          haptic: true,
          tabBackgroundColor: Color(0xff3FBDF1).withOpacity(.2),
          tabBorderRadius: 30,
          gap: 15,
          iconSize: 30,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Beranda',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
