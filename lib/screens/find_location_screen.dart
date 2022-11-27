import 'package:flutter/material.dart';
import 'package:metch/domain/models/club.dart';
import 'package:metch/domain/services/club_service.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class FindLocationScreen extends StatefulWidget {
  const FindLocationScreen({Key? key}) : super(key: key);

  @override
  State<FindLocationScreen> createState() => _FindLocationScreenState();
}

class _FindLocationScreenState extends State<FindLocationScreen> {
  late ClubService clubService;
  late Future<List<Club>> futureClub;

  @override
  void initState() {
    super.initState();
    clubService = ClubService();
    futureClub = clubService.searchClubs("");
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
              'Set Location',
              style: headline1Bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
        child: Column(
          children: [
            TextField(
              autofocus: false,
              onChanged: (value) => setState(() {
                futureClub = clubService.searchClubs(value);
              }),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: '',
              ),
              style: headline4,
            ),
            FutureBuilder<List<Club>>(
              future: futureClub,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'No locations have been found',
                        style: headline4,
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: GestureDetector(
                          onTap: () {
                            debugPrint(snapshot.data![index].name);
                          },
                          child: Text(
                            snapshot.data![index].name,
                            style: headline4,
                          ),
                        ),
                      );
                    },
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
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
