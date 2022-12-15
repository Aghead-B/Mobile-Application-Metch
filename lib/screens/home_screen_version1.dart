import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metch/screens/setup_match_screen.dart';
import 'package:metch/screens/share_match_screen.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import 'package:uni_links/uni_links.dart';


class HomeScreenVersion1 extends StatefulWidget {
  const HomeScreenVersion1({Key? key}) : super(key: key);

  @override
  _HomeScreenVersion1State createState() => _HomeScreenVersion1State();
}

class _HomeScreenVersion1State extends State<HomeScreenVersion1> {

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
          debugPrint(uri.queryParameters['id']);
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    ));
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight= MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff006666), Color(0xff36a3a0)],
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
                      height: currentHeight/8, // adaptive width and height
                      width: currentWidth,
                    ),
                    Image.asset(
                      'assets/images/metchTagLine.png',
                      height: currentHeight/8,// adaptive width and height
                      width: currentWidth/2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, (currentHeight/10.7), 0, 0),
                child: Align(
                  child: Column(
                    children: [
                      SizedBox(
                        height: currentHeight/10.7, //height of button
                        width: currentWidth/2.18, //width of button
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff026969),
                            side: const BorderSide(
                                width: 0.5, // the thickness
                                color: Colors.white // the color of the border
                                ),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const SetupMatchScreen();
                                },
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 50,
                          ),
                          label: const Text(
                            'Setup',
                            style: buttonText,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                        child: const Text(
                          'Select your level. Select Your time.',
                          style: paragraph,
                        ),
                      ),
                      const Text(
                        'Share it on WhatsApp!',
                        style: paragraph,
                      )
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

