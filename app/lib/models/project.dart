class Project {
  final String id;
  final String name;
  final String client;
  final String address;
  final String city;
  final DateTime createdAt;

  const Project({
    required this.id,
    required this.name,
    required this.client,
    required this.address,
    required this.city,
    required this.createdAt,
  });

  Project copyWith({
    String? id,
    String? name,
    String? client,
    String? address,
    String? city,
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      client: client ?? this.client,
      address: address ?? this.address,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get clientDisplay {
    if (client.trim().isEmpty) {
      return address;
    }

    return "$client • $address";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "client": client,
      "address": address,
      "city": city,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map["id"],
      name: map["name"],
      client: map["client"] ?? "",
      address: map["address"] ?? "",
      city: map["city"] ?? "",
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}