import 'package:flutter/material.dart';
import 'package:metch/screens/find_location_screen.dart';
import 'package:metch/screens/setup_match_screen.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../widgets/home_text_button.dart';
import 'find_match_screen.dart';
import 'my_match_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          page: SetupMatchScreen(),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        HomeTextButton(
                          name: "Find Match",
                          icon: Icons.search,
                          page: FindMatchScreen(),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        HomeTextButton(
                          name: "My Match",
                          icon: Icons.calendar_month,
                          page: MyMatchScreen(),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        HomeTextButton(
                          name: "Profile",
                          icon: Icons.person,
                          page: FindMatchScreen(),
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
    );
  }
}
