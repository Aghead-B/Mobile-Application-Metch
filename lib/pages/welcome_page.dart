import 'package:flutter/material.dart';
import 'package:metch/pages/profile_page.dart';
import 'package:metch/pages/setup_match_page.dart';
import 'find_match_page.dart';
import 'home_page.dart';
import 'my_match_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<Widget> pages = const [
    HomePage(),
    FindMatchPage(),
    MyMatchPage(),
    ProfilePage(),
    SetupMatchPage()
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        onTap: onTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              label: '',
              backgroundColor: Colors.white)
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color.fromRGBO(41, 125, 121, 1.000),
      ),
    );
  }
}
