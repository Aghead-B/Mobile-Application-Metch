import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo.png'),
                        const Text(
                          'Metch',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Tahoma',
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                          ),
                        ),
                        const Text(
                          'Find players of your level',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Tahoma',
                            fontSize: 17.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(47, 35, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: const [
                            ListItemWidget(
                                name: 'Setup match', icon: Icons.add),
                            ListItemWidget(
                                name: 'Find match', icon: Icons.search),
                            ListItemWidget(
                                name: 'My match', icon: Icons.calendar_month),
                            ListItemWidget(name: 'Profile', icon: Icons.person),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            backgroundColor: const Color.fromRGBO(53, 162, 158, 1.000),
            bottomNavigationBar: const BottomNavigation()));
  }
}

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key, required this.name, required this.icon});

  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Tahoma',
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
