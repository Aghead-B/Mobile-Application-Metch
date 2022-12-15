import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metch/screens/setup_match_screen.dart';
import 'package:metch/screens/share_match_screen.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import 'package:uni_links/uni_links.dart';
import '../widgets/home_text_button.dart';
import 'find_match_screen.dart';
import 'my_match_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  StreamSubscription? _sub;

  Future<void> handleAppStartLink() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink!= null) {
        var uri = Uri.parse(initialLink);
        if(uri.queryParameters['id'] != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ShareMatchScreen(matchId: int.parse(uri.queryParameters['id'].toString()));
              },
            ),
          );
        }
      }
    } on PlatformException {
      throw Exception("Receiving initial link did not succeed");
    }
  }

  Future<void> handleAppInBackgroundLink() async {
    _sub = linkStream.listen((String? link) {
      if (link!= null) {
        var uri = Uri.parse(link);
        if(uri.queryParameters['id'] != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ShareMatchScreen(matchId: int.parse(uri.queryParameters['id'].toString()));
              },
            ),
          );
        }
      }
    }, onError: (err) {
      throw Exception(err);
    });
  }

  @override
  void initState() {
    super.initState();
    handleAppStartLink();
    handleAppInBackgroundLink();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

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
