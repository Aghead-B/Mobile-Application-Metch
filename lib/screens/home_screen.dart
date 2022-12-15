import 'dart:async';

import 'package:flutter/material.dart';
import 'package:metch/screens/profile_screen.dart';
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
