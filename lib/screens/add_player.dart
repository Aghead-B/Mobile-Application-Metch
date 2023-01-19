import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../domain/models/share_match.dart';
import '../domain/services/match_service.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({Key? key, required this.matchId, required this.spot})
      : super(key: key);
  final int matchId;
  final int spot;

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  late Future<SharedMatch> futureMatch;
  late MatchService matchService;
  late bool refresh;

  @override
  void initState() {
    refresh = false;
    matchService = MatchService();
    futureMatch = matchService.getMatch(widget.matchId);
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
    double textSizeCaption = currentWidth / 16.4;

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
            child: const Text(
              "Add player",
              style: headline1Bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<SharedMatch>(
            future: futureMatch,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                  child: Column(
                    children: [
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
                              padding:
                                  EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 25.0)),
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
                              padding:
                                  EdgeInsets.fromLTRB(25.0, 75.0, 0.0, 0.0)),
                          Text(
                              "${snapshot.data!.club.name}\n${snapshot.data!.club.address}, ${snapshot.data!.club.city}",
                              style: headline3),
                        ],
                      ),
                      const Divider(
                        color: secondary800,
                        thickness: 1,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Guest",
                              style: headline1(textSizeCaption),
                            ),
                            GestureDetector(
                              onTap: () {
                                matchService.postGuestPlayer(
                                    widget.matchId, widget.spot);
                                refresh = true;
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Guest added successfully!"),
                                ));
                              },
                              child: const Icon(
                                Icons.add,
                                color: textGrayColor,
                                size: 28.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: secondary800,
                        thickness: 1,
                      ),
                    ],
                  ),
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
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff29b3b0),
              ),
              onPressed: () {
                Navigator.pop(context, refresh);
              },
              child: const Text(
                'Back',
                style: buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
