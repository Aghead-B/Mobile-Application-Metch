import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

import '../domain/models/share_match.dart';
import '../domain/services/match_service.dart';

class PrivateMatchScreen extends StatefulWidget {
  const PrivateMatchScreen({Key? key, required this.matchId}) : super(key: key);
  final int matchId;

  @override
  State<PrivateMatchScreen> createState() => _PrivateMatchScreenState();
}

class _PrivateMatchScreenState extends State<PrivateMatchScreen> {
  late MatchService matchService;
  late Future<SharedMatch> futureMatch;

  @override
  void initState() {
    super.initState();
    matchService = MatchService();
    futureMatch = matchService.getMatch(widget.matchId);
  }

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
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset("assets/images/private_match_bg.png"),
              const Text(
                "Padel",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: secondary900,
                      size: 50,
                    ),
                    Text(
                      "Level 4",
                      style: TextStyle(
                        fontSize: 20,
                        color: secondary800,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                child: Row(
                  children: const [
                    Text(
                      "What is level 4?",
                      style: TextStyle(
                        fontSize: 20,
                        color: secondary800,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: secondary800,
                      size: 35,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            color: secondary800,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Row(
              children: const [
                Text(
                  "Today 14:00 - 15:00",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: secondary800,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 32, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Peakz KBK Amsterdam",
                  style: TextStyle(
                    color: secondary800,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "court 4",
                  style: TextStyle(
                    color: secondary800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 32),
            alignment: Alignment.centerLeft,
            child: const Text(
              "peakz.com",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xB3297d7a),
              ),
            ),
          ),
          Container(
            color: const Color(0xFFf39622),
            width: double.infinity,
            height: 75,
            alignment: Alignment.center,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "This match is private, contact the organizer to join",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: secondary800),
                  onPressed: () {
                    debugPrint("Patat");
                  },
                  child: const Text("setup match"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
