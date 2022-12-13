import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class PrivateMatchScreen extends StatefulWidget {
  const PrivateMatchScreen({Key? key}) : super(key: key);

  @override
  State<PrivateMatchScreen> createState() => _PrivateMatchScreenState();
}

class _PrivateMatchScreenState extends State<PrivateMatchScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
            // For the arrow nav, keep 40
            child: const Text(
              'Match',
              style: headline1Bold,
            ),
          ),
        ),
      ),
      body:Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset("assets/images/private_match_bg.png"),
              const Text(
                "Padel",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ],
          ),
          Container(

          )
        ],
      )

    );
  }
}
