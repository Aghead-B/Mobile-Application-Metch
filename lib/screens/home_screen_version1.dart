import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metch/screens/profile_screen.dart';
import 'package:metch/screens/setup_match_screen.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../widgets/home_text_button.dart';
import 'find_match_screen.dart';
import 'my_match_screen.dart';

class HomeScreenVersion1 extends StatelessWidget {
  const HomeScreenVersion1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    ));

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
                padding: const EdgeInsets.fromLTRB(0, 75, 0, 0),
                child: Align(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 75, //height of button
                        width: 180, //width of button
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
