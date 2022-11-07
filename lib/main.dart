import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_letter_1/profilepage.dart';
import 'sliderbaru.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Landing(),
    );
  }
}

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _currentPage = 0;
  PageController _controller = PageController();

  final List<Widget> _pages = [
    const SliderPage(
        title: "Friendly UI/UX",
        description:
            "Tampilan UI yang friendly sehingga memudahkan pengguna dalam menggunakan aplikasi ini",
        image: "assets/gambar.svg"),
    const SliderPage(
        title: "Easy to Use",
        description:
            "Mudah digunakan dan mudah dipahami sehingga tidak sulit saat penggunaannya",
        image: "assets/pesan.svg"),
    const SliderPage(
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
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? Color(0xff3FBDF1)
                                : Color(0xff3FBDF1).withOpacity(0.5)));
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint);
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 200),
                  height: 70,
                  width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                  decoration: BoxDecoration(
                    color: Color(0xff3FBDF1),
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
