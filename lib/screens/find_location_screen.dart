import 'package:flutter/material.dart';
import 'package:metch/domain/models/club.dart';
import 'package:metch/domain/models/resource.dart';
import 'package:metch/domain/services/club_service.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';
import '../domain/services/resource_service.dart';

class FindLocationScreen extends StatefulWidget {
  const FindLocationScreen({Key? key}) : super(key: key);

  @override
  State<FindLocationScreen> createState() => _FindLocationScreenState();
}

class _FindLocationScreenState extends State<FindLocationScreen> {
  late ResourceService resourceService;
  late Future<List<Resource>> futureResource;
  late ClubService clubService;
  late Future<List<Club>> futureClub;

  @override
  void initState() {
    super.initState();
    resourceService = ResourceService();
    futureResource = resourceService.getResource(35);

    clubService = ClubService();
    futureClub = clubService.searchClubs("");
  }

  @override
  Widget build(BuildContext context) {
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: primary700,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: primary700,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search location',
              ),
              style: headline4Black,
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
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
                        child: GestureDetector(
                          onTap: () {
                            var club = Club(
                                id: snapshot.data![index].id,
                                name: snapshot.data![index].name);
                            Navigator.pop(context, club);
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
                  debugPrint(snapshot.error.toString());
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Text(
                      'Something went wrong with retrieving the clubs. Please try again later.',
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
            ),
          ],
        ),
      ),
    );
  }
}
