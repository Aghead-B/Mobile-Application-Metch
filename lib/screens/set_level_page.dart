import 'package:flutter/material.dart';
import 'package:metch/domain/models/Level.dart';
import 'package:metch/domain/services/resource_service.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../widgets/videoplayer/video_player.dart';

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
  late ResourceService resourceService;

  String setLevelText = '';

  @override
  void initState() {
    super.initState();
    resourceService = ResourceService();
    resourceService.getResource([1525]).then((value) => {
          setState(() {
            setLevelText = value[0].value;
          }),
        });
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
            child: Text(
              setLevelText,
              style: headline1Bold,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  child: Text("Min", style: headline1(currentWidth / 16.4)),
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
                          firstDropdown = secondDropdown;
                          secondDropdown = value;
                        } else {
                          firstDropdown = value;
                        }
                      });
                    },
                    items: minimumLevelList
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
                Text(
                  "Max",
                  style: headline1(currentWidth / 16.4),
                ),
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
                          secondDropdown = firstDropdown;
                          firstDropdown = value;
                        } else {
                          secondDropdown = value;
                        }
                      });
                    },
                    items: maximumLevelList
                        .map<DropdownMenuItem<int>>((int value) {
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
                backgroundColor: const Color(0xff29b3b0),
              ),
              onPressed: () {
                Navigator.pop(context,
                    Level(levelMin: firstDropdown, levelMax: secondDropdown));
              },
              child: Text(
                setLevelText,
                style: buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
