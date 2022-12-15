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

  const SharedMatch(
      {required this.id,
      required this.date,
      required this.court,
      required this.levelMin,
      required this.levelMax,
      required this.duration,
      required this.spots,
      required this.club,
      this.planned});

  factory SharedMatch.fromJson(Map<String, dynamic> json) {
    return SharedMatch(
      id: json['Id'],
        date: json['Created'],
        court: json['Court'],
        levelMin: json['LevelMin'],
        levelMax: json['LevelMax'],
        duration: json['Duration'],
        spots: json['Spots'],
        club: Club(id: json['Club']['Id'].toString(), name: json['Club']['Name'], city: json['Club']['City'], address: json['Club']['Address'], url: json['Club']['URL']),
        planned: json['Planned']);
  }
}
