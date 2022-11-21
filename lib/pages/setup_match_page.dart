import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/dropdown.dart';

const List<String> playersList = <String>[
  '1 players',
  '2 players',
  '3 players',
  '4 players'
];

const List<String> durationList = <String>[
  '60 min',
  '90 min',
  '120 min',
];

const List<String> courtList = <String>[
  '1',
  '2',
  '3',
  '4',
];

class SetupMatch extends StatefulWidget {
  const SetupMatch({Key? key}) : super(key: key);

  @override
  State<SetupMatch> createState() => _SetupMatchState();
}

class _SetupMatchState extends State<SetupMatch> {

  Future<TimeOfDay?> pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: date.hour, minute: date.minute),
  );

  DateTime date = DateTime.now();

  late dynamic formattedDate;
  late dynamic formattedTime;

  String playersValue = playersList[1];
  String durationValue = durationList[1];
  String courtValue = courtList[1];

  @override
  void initState() {
    formattedDate = DateFormat('d-MMM').format(date);
    formattedTime = DateFormat('Hm').format(date);
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
                const Text(
                  'Level 2-3',
                  style: headline1,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('Redirect to the level screen');
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Padelbaan Amstelveen',
                    style: headline1,
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('Redirect to location selector');
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                ],
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
                          formattedDate,
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
                          formattedTime,
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
                        formattedTime = DateFormat('Hm').format(date);
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
                Column(
                  children: const [
                    Text(
                      '  Only select if you booked a court.',
                      style: caption,
                    ),
                    Text(
                      'We NOT book a court for you!.',
                      style: caption,
                    ),
                  ],
                )
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
                onPressed: () {
                  debugPrint(
                      '{level2-3, Padelbaan Amstelveen, $playersValue, $formattedDate, $formattedTime, $durationValue, $courtValue}');
                },
                child: const Text(
                  'Setup Match',
                  style: buttonText,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
