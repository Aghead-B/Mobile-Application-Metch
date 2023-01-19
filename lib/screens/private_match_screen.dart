import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:metch/screens/remove_player.dart';
import 'package:metch/screens/setup_match_screen.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import 'package:metch/domain/models/share_match.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../domain/services/match_service.dart';
import 'package:flutter_share/flutter_share.dart';
import '../domain/services/resource_service.dart';
import 'add_player.dart';

class PrivateMatchScreen extends StatefulWidget {
  const PrivateMatchScreen({Key? key, required this.matchId}) : super(key: key);
  final int matchId;

  @override
  _PrivateMatchScreenState createState() => _PrivateMatchScreenState();
}

class _PrivateMatchScreenState extends State<PrivateMatchScreen> {
  late ResourceService resourceService;
  late MatchService matchService;
  late Future<SharedMatch> futureMatch;
  late bool refresh;

  String shareMatchTitle = '';
  String shareButtonText = '';
  String cancelButton = '';
  String headTitle = '';
  String openText = '';
  String setupMatchText = '';

  @override
  void initState() {
    refresh = false;
    matchService = MatchService();
    futureMatch = matchService.getMatch(widget.matchId);
    resourceService = ResourceService();
    resourceService.getResource([1522, 1532, 1304, 1101, 324]).then((value) => {
          setState(() {
            setupMatchText = value[0].value;
            shareMatchTitle = value[1].value;
            shareButtonText = value[2].value;
            cancelButton = value[3].value;
            openText = value[4].value;
          }),
        });
    super.initState();
  }

  String convertDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    var formattedDate = DateFormat('EEEE dd MMMM').format(dateTime);
    return formattedDate;
  }

  String convertDateIntoTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    var formattedDate = DateFormat('HH:mm').format(dateTime);
    return formattedDate;
  }

  String addDuration(String startTime, int durationMatch) {
    Duration duration = Duration(minutes: durationMatch);
    DateTime startMatchTime = DateTime.parse(startTime);
    DateTime endTimeDateTimeFormat = startMatchTime.add(duration);

    var formattedDate = DateFormat('HH:mm').format(endTimeDateTimeFormat);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
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
          title: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
              // For the arrow nav, keep 40
              child: Text(
                shareMatchTitle,
                style: headline1Bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<SharedMatch>(
            future: futureMatch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
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
                            children: [
                              Icon(
                                Icons.star,
                                color: secondary900,
                                size: currentWidth / 7.86,
                              ),
                              Text(
                                "Level ${snapshot.data!.levelMin.toString()}",
                                style: TextStyle(
                                  fontSize: currentWidth / 19.65,
                                  color: secondary800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                          child: Row(
                            children: [
                              Text(
                                "What is level ${snapshot.data!.levelMin.toString()}?",
                                style: TextStyle(
                                  fontSize: currentWidth / 19.65,
                                  color: secondary800,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: secondary800,
                                size: currentWidth / 11.2,
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
                    Row(children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0)),
                      Text(
                        convertDate(snapshot.data!.planned.toString()),
                        style: TextStyle(
                          fontSize: currentWidth / 19.65,
                          fontWeight: FontWeight.bold,
                          color: textGrayColor,
                        ),
                      ),
                    ]),
                    Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 25.0)),
                        Text(
                          "${convertDateIntoTime(snapshot.data!.planned.toString())} - ${addDuration(snapshot.data!.planned.toString(), snapshot.data!.duration)}, Court ${snapshot.data!.court.toString()}",
                          style: TextStyle(
                            fontSize: currentWidth / 19.65,
                            fontWeight: FontWeight.bold,
                            color: textGrayColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(25.0, 75.0, 0.0, 0.0)),
                        Text(
                            "${snapshot.data!.club.name}\n${snapshot.data!.club.address}, ${snapshot.data!.club.city}",
                            style: headline3),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Linkify(
                        onOpen: (link) {
                          launch(snapshot.data!.club.url.toString());
                        },
                        text: snapshot.data!.club.url,
                        style: const TextStyle(fontSize: 18),
                        options:
                            LinkifyOptions(humanize: true, removeWww: true),
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondary800),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const SetupMatchScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(setupMatchText),
                          ),
                        ],
                      ),
                    )
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                      ),
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ));
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Shared match using Metch.io',
      text: 'Play padel with me using Metch! Join me with the link below:',
      linkUrl: 'https://metch.io/match/?id=${widget.matchId}',
    );
  }
}
