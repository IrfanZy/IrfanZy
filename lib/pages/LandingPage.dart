// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/fragments/LandingFragment.dart';
import 'package:quick_letter_1/pages/FirstPage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  final List<Widget> _pages = [
    const LandingFragment(
        title: "Friendly UI/UX",
        description:
            "Tampilan UI yang friendly sehingga memudahkan pengguna dalam menggunakan aplikasi ini",
        image: "assets/gambar.svg"),
    const LandingFragment(
        title: "Easy to Use",
        description:
            "Mudah digunakan dan mudah dipahami sehingga tidak sulit saat penggunaannya",
        image: "assets/pesan.svg"),
    const LandingFragment(
        title: "Fast Print",
        description:
            "Sistem dapat mengisi dan langsung mencetak sesuai dengan pilihan surat yang dipilih oleh user",
        image: "assets/telepon.svg"),
  ];

  _onchanged(int index) {
    setState(
      () {
        _currentPage = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  _pages.length,
                  (int index) {
                    return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? const Color(0xff3FBDF1)
                                : const Color(0xff3FBDF1).withOpacity(0.5)));
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  if (_controller.page != 2) {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOutQuint);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EaxmplePage(),
                      ),
                    );
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 200),
                  height: 70,
                  width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                  decoration: BoxDecoration(
                    color: const Color(0xff3FBDF1),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: (_currentPage == (_pages.length - 1))
                      ? const Text(
                          "Mulai",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                      : const Icon(
                          Icons.navigate_next,
                          size: 50,
                          color: Colors.white,
                        ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
