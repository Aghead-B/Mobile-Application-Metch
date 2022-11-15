import 'package:flutter/material.dart';
import 'package:metch/pages/find_match_page.dart';
import 'package:metch/pages/my_match_page.dart';
import 'package:metch/pages/setup_match_page.dart';
import 'package:metch/widgets/home_text_button.dart';
import './widgets/bottom_navigation.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

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
                          style: title,
                        ),
                        const Text(
                          'Find players of your level',
                          style: paragraph,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(47, 35, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              HomeTextButton(
                                name: "Setup Match",
                                icon: Icons.add,
                                page: SetupMatchPage(),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              HomeTextButton(
                                name: "Find Match",
                                icon: Icons.search,
                                page: FindMatchPage(),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              HomeTextButton(
                                name: "My Match",
                                icon: Icons.calendar_month,
                                page: MyMatchPage(),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              HomeTextButton(
                                name: "Profile",
                                icon: Icons.person,
                                page: FindMatchPage(),
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
            backgroundColor: const Color.fromRGBO(53, 162, 158, 1.000),
            bottomNavigationBar: const BottomNavigation()));
  }
}
