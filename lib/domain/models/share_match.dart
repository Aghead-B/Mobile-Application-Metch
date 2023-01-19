import 'dart:convert';

import 'package:metch/domain/models/players.dart';

import 'club.dart';

class SharedMatch {
  final int id;
  final String date;
  final int court;
  final int levelMin;
  final int levelMax;
  final int duration;
  final int spots;
  final Club club;
  final String? planned;
  final List<Players> players;

  const SharedMatch(
      {required this.id,
      required this.date,
      required this.court,
      required this.levelMin,
      required this.levelMax,
      required this.duration,
      required this.spots,
      required this.club,
      this.planned,
      required this.players});

  factory SharedMatch.fromJson(Map<String, dynamic> json) {
    List<Players> players = [];
    List<dynamic> playersResponse = json['Players'];
    var it = playersResponse.iterator;

    while (it.moveNext()) {
      if (it.current != null) {
        players.add(Players(
          id: it.current['Id'].toString() == "0"
              ? "0"
              : it.current['Id'].toString(),
          name: it.current['Name'] == null
              ? "Guest"
              : it.current['Name'].toString(),
          short: it.current['Short'] == null
              ? "Guest"
              : it.current['Short'].toString(),
        ));
      } else {
        players.add(const Players(id: "-1", name: "null", short: "null"));
      }
    }

    print(players.toString());

    return SharedMatch(
        id: json['Id'],
        date: json['Created'],
        court: json['Court'],
        levelMin: json['LevelMin'],
        levelMax: json['LevelMax'],
        duration: json['Duration'],
        spots: json['Spots'],
        club: Club(
            id: json['Club']['Id'].toString(),
            name: json['Club']['Name'],
            city: json['Club']['City'],
            address: json['Club']['Address'],
            url: json['Club']['URL']),
        planned: json['Planned'],
        players: players);
  }
}
