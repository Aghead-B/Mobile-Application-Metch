class Resource {
  final String id;
  final String value;

  const Resource({
    required this.id,
    required this.value,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(id: json['Id'], value: json['Value']);
  }
}
