import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:metch/screens/remove_player.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import 'package:metch/domain/models/share_match.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../domain/services/match_service.dart';
import 'package:flutter_share/flutter_share.dart';
import '../domain/services/resource_service.dart';
import 'add_player.dart';

class ShareMatchScreen extends StatefulWidget {
  const ShareMatchScreen({Key? key, required this.matchId}) : super(key: key);
  final int matchId;

  @override
  _ShareMatchScreenState createState() => _ShareMatchScreenState();
}

class _ShareMatchScreenState extends State<ShareMatchScreen> {
  late ResourceService resourceService;
  late MatchService matchService;
  late Future<SharedMatch> futureMatch;
  late bool refresh;

  String shareMatchTitle = '';
  String shareButtonText = '';
  String cancelButton = '';
  String headTitle = '';
  String openText = '';

  bool isOwner = false;
  bool isVisible = true;

  @override
  void initState() {
    refresh = false;
    matchService = MatchService();
    futureMatch = matchService.getMatch(widget.matchId);
    resourceService = ResourceService();
    resourceService.getResource([1532, 1304, 1101, 324]).then((value) => {
          setState(() {
            shareMatchTitle = value[0].value;
            shareButtonText = value[1].value;
            cancelButton = value[2].value;
            openText = value[3].value;
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

  checkOwner(int? ownerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdFromCache = prefs.getString('userId');
    if (ownerId == int.parse(userIdFromCache!)) {
      setState(() {
        isOwner = true;
        isVisible = false;
      });
    }
    else {
      setState(() {
        isOwner = false;
        isVisible = false;
      });
    }
  }

  onClickCancel() {
    matchService.cancelMatch(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    Future<void> _navigateAndAddPlayer(BuildContext context, int spot) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AddPlayerPage(matchId: widget.matchId, spot: spot)),
      );
      if (result != null && result == true) {
        initState();
      }
    }

    Future<void> _navigateAndRemovePlayer(
        BuildContext context, int spot) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RemovePlayerPage(matchId: widget.matchId, spot: spot)),
      );
      if (result != null && result == true) {
        initState();
      }
    }

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
                checkOwner(snapshot.data?.ownerId);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0)),
                        Column(
                          children: [
                            const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0)),
                            GestureDetector(
                              child: const Icon(
                                color: textGrayColor,
                                size: 70,
                                Icons.person_pin,
                              ),
                            ),
                            Text(
                              snapshot.data!.players.first.short,
                              style: const TextStyle(color: textGrayColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(50.0, 0.0, 40.0, 0.0)),
                            GestureDetector(
                              onTap: () {
                                snapshot.data!.players[1].id != "-1"
                                    ? _navigateAndRemovePlayer(context, 3)
                                    : _navigateAndAddPlayer(context, 3);
                              },
                              child: snapshot.data!.players[1].id != "-1"
                                  ? const Icon(
                                      color: textGrayColor,
                                      size: 70,
                                      Icons.person_pin,
                                    )
                                  : const Icon(
                                      color: textGrayColor,
                                      size: 70,
                                      Icons.person_add,
                                    ),
                            ),
                            Text(
                              snapshot.data!.players[1].id != "-1"
                                  ? snapshot.data!.players[1].short
                                  : openText,
                              style: const TextStyle(color: textGrayColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0)),
                            GestureDetector(
                              onTap: () {
                                snapshot.data!.players[2].id != "-1"
                                    ? _navigateAndRemovePlayer(context, 2)
                                    : _navigateAndAddPlayer(context, 2);
                              },
                              child: snapshot.data!.players[2].id != "-1"
                                  ? const Icon(
                                      color: textGrayColor,
                                      size: 70,
                                      Icons.person_pin,
                                    )
                                  : const Icon(
                                      color: textGrayColor,
                                      size: 70,
                                      Icons.person_add,
                                    ),
                            ),
                            Text(
                              snapshot.data!.players[2].id != "-1"
                                  ? snapshot.data!.players[2].short
                                  : openText,
                              style: const TextStyle(color: textGrayColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(40.0, 0.0, 50.0, 0.0)),
                            GestureDetector(
                              onTap: () {
                                snapshot.data!.players[3].id != "-1"
                                    ? _navigateAndRemovePlayer(context, 4)
                                    : _navigateAndAddPlayer(context, 4);
                              },
                              child: snapshot.data!.players[3].id != "-1"
                                  ? const Icon(
                                      color: textGrayColor,
                                      size: 70,
                                      Icons.person_pin,
                                    )
                                  : const Icon(
                                      color: textGrayColor,
                                      size: 70,
                                      Icons.person_add,
                                    ),
                            ),
                            Text(
                              snapshot.data!.players[3].id != "-1"
                                  ? snapshot.data!.players[3].short
                                  : openText,
                              style: const TextStyle(color: textGrayColor),
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
                                backgroundColor: const Color(0xff29b3b0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                minimumSize: const Size(151, 53)),
                            icon: const Icon(Icons.whatsapp_rounded, size: 40),
                            label: Text(shareButtonText),
                            onPressed: () => {share()},
                          ),
                          AnimatedOpacity(
                            opacity: isOwner ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: ElevatedButton(
                              onPressed: () {
                                if (isOwner) {
                                  onClickCancel();
                                } else {
                                  null;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  textStyle: headline3,
                                  backgroundColor: secondaryBackground,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size(151, 53)),
                              child: Text(
                                cancelButton,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
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
