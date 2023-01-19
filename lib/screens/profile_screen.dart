import 'package:flutter/material.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import 'package:metch/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profilePageText = 'Profile Page';
  bool agheadProfileSelected = false;
  bool devidProfileSelected = false;
  bool haniProfileSelected = false;
  bool michaelProfileSelected = false;



  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: secondaryBackground,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff29b3b0), Color(0xff000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, currentWidth / 15, 0.0),
          child: Center(
            child: Text(
              profilePageText, // needs to be requested from resources
              style: headline1Bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0,
                  currentHeight / 15, 0, currentHeight / 15),
              child: Text(
                "Select your profile",
                style: headline1(28),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  agheadProfileSelected = true;
                  devidProfileSelected = false;
                  haniProfileSelected = false;
                  michaelProfileSelected = false;
                });
                globals.Sid = "9feb1d3e-9734-401e-963a-8a2750ff4b8f";
                globals.userId = "131874";
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(currentWidth / 5,
                        0, 0, currentHeight / 80.3),
                    child: Image.asset(
                      'assets/images/Aghead.png',
                      height: currentHeight / 9.4,
                      width: currentWidth / 4.6,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(currentWidth / 30,
                        0, 0, 0),
                    child: Text(
                      "Aghead",
                      style: agheadProfileSelected
                      ? caption(18, const Color(0xff29b3b0)) // if true
                      : caption(18, textGrayColor), //otherwise
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  agheadProfileSelected = false;
                  devidProfileSelected = true;
                  haniProfileSelected = false;
                  michaelProfileSelected = false;
                });
                globals.Sid = "909365ee-efbc-4c88-863f-59a59275f3d5";
                globals.userId = "131820";
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        currentWidth / 5, 0, 0, currentHeight / 80.3),
                    child: Image.asset(
                      'assets/images/Devid.png',
                      height: currentHeight / 9.4,
                      width: currentWidth / 4.6,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(currentWidth / 30, 0, 0, 0),
                    child: Text(
                      "Devid",
                      style: devidProfileSelected
                          ? caption(18, const Color(0xff29b3b0)) // if true
                          : caption(18, textGrayColor), //otherwise
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  agheadProfileSelected = false;
                  devidProfileSelected = false;
                  haniProfileSelected = true;
                  michaelProfileSelected = false;
                });
                globals.Sid = "a6a02fee-f041-4ae1-b2b9-16f223179f0b";
                globals.userId = "131885";
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        currentWidth / 5, 0, 0, currentHeight / 80.3),
                    child: Image.asset(
                      'assets/images/Hani.png',
                      height: currentHeight / 9.4,
                      width: currentWidth / 4.6,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(currentWidth / 30, 0, 0, 0),
                    child: Text(
                      "Hani",
                      style: haniProfileSelected
                          ? caption(18, const Color(0xff29b3b0)) // if true
                          : caption(18, textGrayColor), //otherwise
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  agheadProfileSelected = false;
                  devidProfileSelected = false;
                  haniProfileSelected = false;
                  michaelProfileSelected = true;
                });
                globals.Sid = "1d7b5943-6073-4474-bbb0-bb89f8194a7c";
                globals.userId = "131818";
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        currentWidth / 5, 0, 0, currentHeight / 80.3),
                    child: Image.asset(
                      'assets/images/Michael.png',
                      height: currentHeight / 9.4,
                      width: currentWidth / 4.6,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(currentWidth / 30, 0, 0, 0),
                    child: Text(
                      "Michael",
                      style: michaelProfileSelected
                          ? caption(18, const Color(0xff29b3b0)) // if true
                          : caption(18, textGrayColor), //otherwise
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
