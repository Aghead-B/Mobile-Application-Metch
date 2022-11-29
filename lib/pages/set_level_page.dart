import 'package:flutter/material.dart';
import 'package:metch/widgets/video/video_player.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

var minimumLevelList = List<int>.generate(10, (i) => i + 1);
var maximumLevelList = List<int>.generate(10, (i) => i + 1);

class SetLevelPage extends StatefulWidget {
  const SetLevelPage({Key? key}) : super(key: key);

  @override
  State<SetLevelPage> createState() => _SetLevelPageState();
}

class _SetLevelPageState extends State<SetLevelPage> {

  int minimumDropdownValue = minimumLevelList[2];
  int maximumDropdownValue = maximumLevelList[6];
  late int firstDropdown = minimumDropdownValue;
  late int secondDropdown = maximumDropdownValue;
  late int temporaryStorage;

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
      body: Column(
          children: [
            const VideoPlayerWidget(),
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    size: 45,
                    color: Colors.orange,
                  ),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                      child: Text("Min", style: headline1),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 0.0),
                    height: 40.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: DropdownButton<int>(
                      dropdownColor: Colors.white,
                      value: firstDropdown,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      elevation: 0,
                      style: secondaryText,
                      onChanged: (int? value) {
                        setState(() {
                          if (value! > secondDropdown) {
                            temporaryStorage = secondDropdown;
                            secondDropdown = value;
                            firstDropdown = temporaryStorage;
                          } else {
                            firstDropdown = value;
                          }
                        });
                      },
                      items: minimumLevelList.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  const Text("Max", style: headline1),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                    height: 40.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: DropdownButton<int>(
                      dropdownColor: Colors.white,
                      value: secondDropdown,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      elevation: 0,
                      style: secondaryText,
                      onChanged: (int? value) {
                        setState(() {
                          if (value! < firstDropdown) {
                            temporaryStorage = firstDropdown;
                            firstDropdown = value;
                            secondDropdown = temporaryStorage;
                          } else {
                            secondDropdown = value;
                          }
                        });
                      },
                      items: maximumLevelList.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(242, 139, 32, 1.000),
                ),
                onPressed: () {
                  debugPrint(
                      '{"levelMin":$firstDropdown, "levelMax":$secondDropdown}');
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
    );
  }
}
