class Club {
  final int id;
  final String name;

  const Club({
    required this.id,
    required this.name,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['Id'],
      name: json['Name'],
    );
  }
}