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
        title: "Tampilan Sederhana",
        description:
            "Tampilan aplikasi yang sederhana sehingga dapat memudahkan pengguna",
        image: "assets/svg/Gambar.svg"),
    const LandingFragment(
        title: "Kelola Data Warga",
        description:
            "Kepengurusan RT dapat dengan mudah mengelola data warga dengan menggunakan aplikasi ini",
        image: "assets/svg/Pesan.svg"),
    const LandingFragment(
        title: "Fast Print",
        description:
            "Warga dapat mengisi dan langsung mencetak surat keterangan dengan mengisi form yang telah disediakan",
        image: "assets/svg/Telepon.svg"),
  ];

  _onchanged(int index) {
    setState(
      () {
        _currentPage = index;
      },
    );
  }

  @override
  void initState() {
    super.initState();
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
                      curve: Curves.easeInOutQuint,
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FirstPage(),
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
