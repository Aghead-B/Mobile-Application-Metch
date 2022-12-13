import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metch/domain/models/Level.dart';
import 'package:metch/domain/models/match.dart';
import 'package:metch/domain/services/match_service.dart';
import 'package:metch/screens/find_location_screen.dart';
import 'package:metch/screens/set_level_page.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../domain/models/club.dart';
import '../domain/models/resource.dart';
import '../domain/services/resource_service.dart';
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
  late ResourceService resourceService;
  late Future<List<Resource>> futureResource;
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
    resourceService = ResourceService();
    futureResource =
        resourceService.getResource("1522,1525,1526,1527,1528,1117,1531");
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    displayDate = DateFormat('d-MMM').format(date);
    formattedTime = DateFormat('HH:mm:ss.SSS').format(date);
    displayTime = DateFormat('Hm').format(date);
    toggleButton = true;
    matchService = MatchService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Resource>>(
      future: futureResource,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                  child: Text(
                    snapshot.data![0].value,
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
                            ? snapshot.data![1].value
                            : "Level ${level.levelMin}-${level.levelMax}",
                        style: headline1,
                      ),
                      GestureDetector(
                        onTap: () {
                          _navigateAndGetLevelSelection(context);
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Color(0xff71716f),
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
                            club.name == '' ? snapshot.data![2].value : club.name,
                            style: headline1,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Color(0xff71716f),
                            size: 28.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Color(0xff71716f),
                          size: 30.0,
                        ),
                        Text(
                          snapshot.data![3].value,
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
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Color(0xff71716f),
                          size: 30.0,
                        ),
                        Text(
                          snapshot.data![4].value,
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
                                  formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
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
                              formattedTime =
                                  DateFormat('HH:mm:ss.SSS').format(date);
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
                      children: [
                        const Icon(
                          Icons.sports_tennis_sharp,
                          color: Color(0xff71716f),
                          size: 30.0,
                        ),
                        Text(
                          snapshot.data![5].value,
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
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Column(
                            children: [
                              Text(
                                snapshot.data![6].value,
                                style: caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff29b3b0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: toggleButton ? () => setupMatch() : null,
                      child: Text(
                        snapshot.data![0].value,
                        style: buttonText,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Text(
              'Something went wrong. Please try again later.',
              style: headline4,
            ),
          );
        }
        return const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      },
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
