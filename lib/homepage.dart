import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Set timer untuk mengatur perpindahan slide setiap 5 detik
    _timer = Timer.periodic(Duration(seconds: 8), (timer) {
      if (_currentPage < 3) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    // Hapus timer saat widget dihapus dari layar
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 238, 226),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    "Selamat Ulang Tahun Kamu",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontFamily: "YourChosenGoogleFont",
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: _pageController,
                      itemCount: 4,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 1;
                            if (_pageController.position.haveDimensions) {
                              value = _pageController.page! - index.toDouble();
                              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                            }
                            return Center(
                              child: SizedBox(
                                // height: Curves.easeOut.transform(value) * 400,
                                // width: Curves.easeOut.transform(value) * 300,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 238, 226),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Image.asset(
                              'asset/${index + 1}.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '"Berulang tahun bukanlah tentang bertambahnya usia, tetapi bertambahnya pengalaman, kebijaksanaan, dan kebahagiaan di dalam hidup"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontFamily: "YourChosenGoogleFont",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
