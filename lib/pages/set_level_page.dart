import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metch/widgets/star_rating_dropdown.dart';
import 'package:video_player/video_player.dart';

const List<String> minimumLevelList = <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
];

const List<String> maximumLevelList = <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
];


class SetLevelPage extends StatefulWidget {
  const SetLevelPage({Key? key}) : super(key: key);

  @override
  State<SetLevelPage> createState() => _SetLevelPageState();
}

class _SetLevelPageState extends State<SetLevelPage> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/test.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  String minimumDropdownValue = minimumLevelList[1];
  String maximumDropdownValue = minimumLevelList[3];
  late String minimumSelectedValue = minimumDropdownValue;
  late String maximumSelectedValue = maximumDropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 162, 158, 1.000),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(41, 125, 121, 1.000),
        title: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
            child: const Text(
              'Set Level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
        child: Column(
          children: [
            StarRatingDropdown(
                text: "Minimum",
                dropdownValue: minimumDropdownValue,
                list: minimumLevelList,
                icon: Icons.keyboard_arrow_down,
                onChanged: (value) {
                minimumSelectedValue = value;
                },
                limitValue: maximumSelectedValue,
                
            ),
            StarRatingDropdown(
                text: "Maximum",
                dropdownValue: maximumDropdownValue,
                list: maximumLevelList,
                icon: Icons.keyboard_arrow_down,
                onChanged: (value) {
                  maximumSelectedValue = value;
                },
                limitValue: minimumSelectedValue,
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              ),
              _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController))
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.05)),
                          fixedSize: MaterialStateProperty.all(const Size(30, 30)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)))),
                      onPressed: () {
                        _videoPlayerController.pause();
                      },
                      child: const Icon(Icons.pause)),
                  const Padding(padding: EdgeInsets.all(2)),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.05)),
                          fixedSize: MaterialStateProperty.all<Size>(const Size(30, 30)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)))),
                      onPressed: () {
                        _videoPlayerController.play();
                      },
                      child: const Icon(Icons.play_arrow))
                ],
              )
            ],
          ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(242, 139, 32, 1.000),
                ),
                onPressed: () {
                  print(minimumSelectedValue + maximumSelectedValue);
                },
                child: const Text(
                  'Set Level',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Tahoma',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
