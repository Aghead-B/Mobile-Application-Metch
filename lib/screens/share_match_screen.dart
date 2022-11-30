import 'package:flutter/material.dart';
import 'package:metch/domain/services/match_service.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import 'package:metch/domain/models/match.dart';


class ShareMatchScreen extends StatefulWidget {
  const ShareMatchScreen({Key? key}) : super(key: key);

  @override
  State<ShareMatchScreen> createState() => _ShareMatchScreenState();
}

class _ShareMatchScreenState extends State<ShareMatchScreen> {
  late MatchService matchService;
  late Future<Match> futureMatch;

  @override
  void initState() {
    super.initState();
    matchService = MatchService();
    futureMatch = matchService.searchMatch(50);
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
      body: FutureBuilder<Match>(
          future: futureMatch,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                          '${snapshot.data!.levelMin.toString()} - ${snapshot.data!.levelMax.toString()} ',
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
                      snapshot.data!.planned.toString(),
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
                      snapshot.data!.duration.toString(),
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
                    Text("${snapshot.data!.club.name}, ${snapshot.data!.court}", style: headline3),
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
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Text(
                '${snapshot.error}',
                style: headline4,
              ),
            );
          }
          return const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
