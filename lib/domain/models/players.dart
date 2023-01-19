class Players {
  final String id;
  final String name;
  final String short;


  const Players({
    required this.id,
    required this.name,
    required this.short,

  });

  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(
        id: json['Id'],
        name: json['Name'],
        short: json['Short']
    );
  }
}
