import 'package:flutter/material.dart';
import 'package:metch/domain/services/match_service.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class ShareMatchScreen extends StatefulWidget {
  const ShareMatchScreen({Key? key}) : super(key: key);

  @override
  State<ShareMatchScreen> createState() => _ShareMatchScreenState();
}

class _ShareMatchScreenState extends State<ShareMatchScreen> {
  late MatchService matchService;
  late Future<Match> match;

  late final String level = "3-4";
  late final String date = "Monday 11 November";
  late final String time = "13.00 - 14.30";
  late final String location = "Padelbaan Amstelveen";
  late final String court = "court 2";

  @override
  void initState() {
    super.initState();
    matchService = MatchService();
    // match = matchService.searchMatch(40);
    var matchv2 = matchService.searchMatch(40);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary500,
      appBar: AppBar(
        backgroundColor: primary700,
        title: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
            // For the arrow nav, keep 40
            child: const Text(
              'Share Match',
              style: headline1Bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25.0),
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: Image.asset(
                    width: double.infinity, "assets/images/padel.png"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                  ),
                  Text(
                    level,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 55),
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 55,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0)),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0)),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(25.0, 50.0, 0.0, 0.0)),
              Text("$location, $court", style: headline3),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0)),
              Column(
                children: const [
                  Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0)),
                  Icon(color: Colors.white, size: 70, Icons.panorama_fish_eye),
                  Text(
                    "open",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: const [
                  Padding(padding: EdgeInsets.fromLTRB(50.0, 0.0, 40.0, 0.0)),
                  Icon(color: Colors.white, size: 70, Icons.panorama_fish_eye),
                  Text(
                    "open",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: const [
                  Padding(padding: EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0)),
                  Icon(color: Colors.white, size: 70, Icons.panorama_fish_eye),
                  Text(
                    "open",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: const [
                  Padding(padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0)),
                  Icon(color: Colors.white, size: 70, Icons.panorama_fish_eye),
                  Text(
                    "open",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      textStyle: headline3,
                      backgroundColor: secondary500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(151, 53)),
                  icon: const Icon(Icons.whatsapp_rounded, size: 40),
                  label: const Text("Share"),
                  onPressed: () => {debugPrint("Shared match")},
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint("Match Canceled");
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: headline3,
                      backgroundColor: secondary800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(151, 53)),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
