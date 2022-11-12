import 'package:flutter/material.dart';
import './widgets/list_item.dart';
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
