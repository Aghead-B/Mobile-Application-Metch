class Club {
  final String id;
  final String name;
  final String? city;
  final String? address;
  final String? url;

  const Club({
    required this.id,
    required this.name,
    this.city,
    this.address,
    this.url,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
        id: json['Id'],
        name: json['Name'],
        city: json['City'],
        address: json['Address'],
        url: json['URL']);
  }
}
