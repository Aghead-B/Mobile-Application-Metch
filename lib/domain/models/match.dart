class Match {
  final int clubid;
  final int sportid;
  final int levelmin;
  final String planned;
  final int duration;
  final int spots;
  final int? levelmax;
  final int? court;

  const Match({
    required this.clubid,
    required this.sportid,
    required this.levelmin,
    required this.planned,
    required this.duration,
    required this.spots,
    this.levelmax,
    this.court,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      clubid: json['clubid'],
      sportid: json['sportid'],
      levelmin: json['levelmin'],
      planned: json['planned'],
      duration: json['duration'],
      spots: json['spots'],
      levelmax: json['levelmax'],
      court: json['court'],
    );
  }
}

class MatchCreated {
  final int id;

  const MatchCreated ({
    required this.id
});

  factory MatchCreated.fromJson(Map<String, dynamic> json) {
    return MatchCreated(
      id: json['Id']
    );
  }
}