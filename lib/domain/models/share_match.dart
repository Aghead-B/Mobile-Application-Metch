import 'club.dart';

class Match {
  final int id;
  final String date;
  final int court;
  final int levelMin;
  final int levelMax;
  final int duration;
  final int spots;
  final Club club;
  final String? planned;

  const Match(
      {required this.id,
      required this.date,
      required this.court,
      required this.levelMin,
      required this.levelMax,
      required this.duration,
      required this.spots,
      required this.club,
      this.planned});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['Id'],
        date: json['Created'],
        court: json['Court'],
        levelMin: json['LevelMin'],
        levelMax: json['LevelMax'],
        duration: json['Duration'],
        spots: json['Spots'],
        club: Club(id: json['Club']['Id'].toString(), name: json['Club']['Name']),
        planned: json['Planned']);
  }
}
