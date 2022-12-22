import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metch/domain/models/Level.dart';
import 'package:metch/domain/models/match.dart';
import 'package:metch/domain/services/match_service.dart';
import 'package:metch/screens/find_location_screen.dart';
import 'package:metch/screens/set_level_page.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../domain/models/club.dart';
import '../widgets/dropdown.dart';
import 'package:metch/screens/share_match_screen.dart';

const List<String> playersList = <String>[
  '1 player',
  '2 players',
  '3 players',
];

const List<String> durationList = <String>[
  '60 min',
  '90 min',
  '120 min',
];

const List<String> courtList = <String>[
  '0',
  '1',
  '2',
  '3',
  '4',
];

class SetupMatchScreen extends StatefulWidget {
  const SetupMatchScreen({Key? key}) : super(key: key);

  @override
  State<SetupMatchScreen> createState() => _SetupMatchScreenState();
}

class _SetupMatchScreenState extends State<SetupMatchScreen> {
  late String formattedDate;
  late String displayDate;
  late String formattedTime;
  late String displayTime;
  late Future<MatchCreated> matchCreated;
  late MatchService matchService;
  late bool toggleButton;
  final int SPORT_ID_PADEL = 109;
  Club club = const Club(id: '', name: '');
  Level level = const Level(levelMin: 0, levelMax: 0);
  DateTime date = DateTime.now();
  String playersValue = playersList[1];
  String durationValue = durationList[1];
  String courtValue = courtList[0];

  Future<TimeOfDay?> pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: date.hour, minute: date.minute),
  );

  Future<void> _navigateAndGetLocationSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindLocationScreen()),
    );

    if (result == null) return;

    setState(() {
      club = result;
    });
  }

  Future<void> _navigateAndGetLevelSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetLevelPage()),
    );

    if (result == null) return;

    setState(() {
      level = result;
    });
  }

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    displayDate = DateFormat('d-MMM').format(date);
    formattedTime = DateFormat('HH:mm:ss.SSS').format(date);
    displayTime = DateFormat('Hm').format(date);
    toggleButton = true;
    matchService = MatchService();
  }

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    double textSizeCaption = currentWidth/16.4;
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
            padding: EdgeInsets.fromLTRB(0.0, 0.0, currentWidth/9.8, 0.0),
            child: const Text(
              'setup match',
              style: headline1Bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(currentWidth/26.2, currentHeight/26.7, currentWidth/26.2, 0.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    level.levelMin == 0 || level.levelMax == 0
                        ? 'Choose level...'
                        : "Level ${level.levelMin}-${level.levelMax}",
                    style: headline1(textSizeCaption),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateAndGetLevelSelection(context);
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: textGrayColor,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _navigateAndGetLocationSelection(context);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0.0, currentHeight/26.7, 0.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        club.name == '' ? 'Choose location...' : club.name,
                        style: headline1(textSizeCaption),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: textGrayColor,
                        size: 28.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, currentHeight/26.7, 0.0, currentWidth/39.3),
                child: Row(
                  children: [
                    Text(
                      ' Looking for',
                      style: headline1(textSizeCaption),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: textGrayColor,
                    size: currentWidth / 9.8,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(currentWidth/13.1, currentHeight/80.3, 0.0, 0.0),
                    height: currentHeight/20.1,
                    width: currentWidth/2.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.fromLTRB(currentWidth/26.2, 0.0, 0.0, 0.0),
                    child: Row(
                      children: [
                        Dropdown(
                          dropdownValue: playersValue,
                          list: playersList,
                          icon: Icons.keyboard_arrow_down,
                          setter: (value) {
                            playersValue = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, currentHeight/40.15, 0.0, 0.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: textGrayColor,
                      size: currentWidth / 9.8,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(currentWidth/13.1, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          fixedSize: Size(currentWidth/2.8, 0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              displayDate,
                              style: secondaryText,
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        onPressed: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              setState(() {
                                date = selectedDate;
                                formattedDate =
                                    DateFormat('yyyy-MM-dd').format(selectedDate);
                                displayDate =
                                    DateFormat('d-MMM').format(selectedDate);
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(currentWidth/39.3, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          fixedSize: Size(currentWidth/3.1, 0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              displayTime,
                              style: secondaryText,
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        onPressed: () async {
                          final time = await pickTime();
                          if (time == null) return; // pressed 'CANCEL'

                          final newDateTime = DateTime(date.year, date.month,
                              date.day, time.hour, time.minute);

                          setState(() {
                            date = newDateTime; // pressed 'OK'
                            formattedTime = DateFormat('HH:mm:ss.SSS').format(date);
                            displayTime = DateFormat('Hm').format(date);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, currentHeight/40.15, 0.0, 0.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: textGrayColor,
                      size: currentWidth / 9.8,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.fromLTRB(currentWidth/13.1, 0.0, 0.0, 0.0),
                      width: currentWidth/3.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Dropdown(
                        dropdownValue: durationValue,
                        list: durationList,
                        icon: Icons.keyboard_arrow_down,
                        setter: (value) {
                          durationValue = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, currentHeight/55.15, 0.0, 0.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.sports_tennis_sharp,
                      color: textGrayColor,
                      size: currentWidth / 9.8,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.fromLTRB(currentWidth/13.1, currentHeight/80.3, 0.0, 0.0),
                      height: currentHeight/20,
                      width: currentWidth/5.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Dropdown(
                          dropdownValue: courtValue,
                          list: courtList,
                          icon: Icons.keyboard_arrow_down,
                          setter: (value) {
                            courtValue = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(currentWidth/26.2, currentHeight/160.1, 0.0, 0.0),
                      child: Column(
                        children:[
                          Text(
                            'Only select if you booked a court.',
                            style: caption(currentWidth / 29.1),
                          ),
                          Text(
                            "We'll NOT book a court for you!.",
                            style: caption(currentWidth / 29.1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, currentHeight/20.1, 0.0, 0.0),
                height: currentHeight/17.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff29b3b0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: toggleButton ? () => setupMatch() : null,
                  child: const Text(
                    'Setup Match',
                    style: buttonText,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setupMatch() async {
    if (club.id != '' && level.levelMin != 0 && level.levelMax != 0) {
      setState(() {
        toggleButton = false;
      });
      String getNumberDuration =
      durationValue.replaceAll(RegExp(r'[^0-9]'), '');
      String getNumberSpot = playersValue.replaceAll(RegExp(r'[^0-9]'), '');
      String combinedISO8601 = "${formattedDate}T${formattedTime}Z";
      Match match = Match(
        clubid: int.parse(club.id),
        sportid: SPORT_ID_PADEL,
        levelmin: level.levelMin,
        planned: combinedISO8601,
        duration: int.parse(getNumberDuration),
        spots: int.parse(getNumberSpot),
        levelmax: level.levelMax,
        court: int.parse(courtValue),
      );
      matchCreated = matchService.postMatch(match);
      await Future.delayed(const Duration(seconds: 1), () {});
      setState(() {
        toggleButton = true;
      });
      matchCreated.then((value) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ShareMatchScreen(matchId: value.id)),
      ));
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Please select a level and location."),
        ));
  }
}