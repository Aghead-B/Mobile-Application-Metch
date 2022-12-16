import 'package:flutter/material.dart';
import 'package:metch/screens/profile_screen.dart';
import 'package:metch/screens/setup_match_screen.dart';
import '../domain/models/resource.dart';
import '../domain/services/resource_service.dart';
import '../widgets/home_text_button.dart';
import 'find_match_screen.dart';
import 'my_match_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff006666), Color(0xff36a4a0)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logoWithShadow.png',
                      height: 100,
                      width: 100,
                    ),
                    Image.asset(
                      'assets/images/metchTagLine.png',
                      height: 100,
                      width: 200,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(95, 35, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          HomeTextButton(
                            name: "setup match",
                            icon: Icons.add,
                            page: SetupMatchScreen(),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          HomeTextButton(
                            name: "find match",
                            icon: Icons.search,
                            page: FindMatchScreen(),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          HomeTextButton(
                            name: "my matches",
                            icon: Icons.access_time_rounded,
                            page: MyMatchScreen(),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          HomeTextButton(
                            name: "profile",
                            icon: Icons.person,
                            page: ProfileScreen(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}