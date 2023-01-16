class Match {
  final int clubId;
  final int sportId;
  final int levelMin;
  final String planned;
  final int duration;
  final int spots;
  final int? levelMax;
  final int? court;

  const Match({
    required this.clubId,
    required this.sportId,
    required this.levelMin,
    required this.planned,
    required this.duration,
    required this.spots,
    this.levelMax,
    this.court,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      clubId: json['clubid'],
      sportId: json['sportid'],
      levelMin: json['levelmin'],
      planned: json['planned'],
      duration: json['duration'],
      spots: json['spots'],
      levelMax: json['levelmax'],
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