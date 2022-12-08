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
  '1 players',
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

    setState(() {
      club = result;
    });
  }

  Future<void> _navigateAndGetLevelSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetLevelPage()),
    );
    setState(() {
      level = result;
    });
  }

  @override
  void initState() {
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    displayDate = DateFormat('d-MMM').format(date);
    formattedTime = DateFormat('HH:mm:ss.SSS').format(date);
    displayTime = DateFormat('Hm').format(date);
    toggleButton = true;
    matchService = MatchService();
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
            child: const Text(
              'Setup Match',
              style: headline1Bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  level.levelMin == 0 || level.levelMax == 0
                      ? 'Choose level...'
                      : "Level ${level.levelMin}-${level.levelMax}",
                  style: headline1,
                ),
                GestureDetector(
                  onTap: () {
                    _navigateAndGetLevelSelection(context);
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
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
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      club.name == '' ? 'Choose location...' : club.name,
                      style: headline1,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  Text(
                    ' Looking for',
                    style: headline1,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 235.0, 0.0),
              height: 40.0,
              width: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              child: Dropdown(
                dropdownValue: playersValue,
                list: playersList,
                icon: Icons.keyboard_arrow_down,
                setter: (value) {
                  playersValue = value;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  Text(
                    ' When',
                    style: headline1,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      fixedSize: const Size(125, 0),
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
                  margin: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      fixedSize: const Size(102, 0),
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
                Container(
                  alignment: AlignmentDirectional.center,
                  margin: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  width: 102.0,
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
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.sports_tennis_sharp,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  Text(
                    ' Court',
                    style: headline1,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  height: 40.0,
                  width: 125.0,
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
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                  child: Column(
                    children: const [
                      Text(
                        'Only select if you booked a court.',
                        style: caption,
                      ),
                      Text(
                        'We do NOT book a court for you!.',
                        style: caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary500,
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
      String CombinedISO8601 = "${formattedDate}T${formattedTime}Z";
      Match match = Match(
          clubid: int.parse(club.id),
          sportid: SPORT_ID_PADEL,
          levelmin: level.levelMin,
          planned: CombinedISO8601,
          duration: int.parse(getNumberDuration),
          spots: int.parse(getNumberSpot),
          levelmax: level.levelMax,
          court: int.parse(courtValue));
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
