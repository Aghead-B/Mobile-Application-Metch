import 'package:flutter/material.dart';
import 'package:metch/domain/models/club.dart';
import 'package:metch/domain/repositories/club_repository.dart';
import 'package:metch/screens/profile_screen.dart';
import 'package:metch/screens/setup_match_screen.dart';
import '../domain/services/club_service.dart';
import 'find_match_screen.dart';
import 'home_screen.dart';
import 'my_match_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  late ClubService clubRepository;

  @override
  void initState() {
    super.initState();
    clubRepository = ClubService();
    clubRepository.searchClubs("sd");
  }

  List<Widget> pages = const [
    HomeScreen(),
    FindMatchScreen(),
    MyMatchScreen(),
    ProfileScreen(),
    SetupMatchScreen()
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
