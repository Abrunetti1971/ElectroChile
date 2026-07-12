class Project {
  final String id;

  final String name;

  final String client;

  final String address;

  final DateTime createdAt;

  const Project({
    required this.id,
    required this.name,
    required this.client,
    required this.address,
    required this.createdAt,
  });

  Project copyWith({
    String? id,
    String? name,
    String? client,
    String? address,
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      client: client ?? this.client,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}