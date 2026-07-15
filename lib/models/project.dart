class Project {
  final String id;
  final String name;
  final String client;
  final String address;
  final String city;
  final String region;
  final String distributor;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Project({
    required this.id,
    required this.name,
    required this.client,
    required this.address,
    required this.city,
    required this.region,
    required this.distributor,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Project copyWith({
    String? id,
    String? name,
    String? client,
    String? address,
    String? city,
    String? region,
    String? distributor,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      client: client ?? this.client,
      address: address ?? this.address,
      city: city ?? this.city,
      region: region ?? this.region,
      distributor: distributor ?? this.distributor,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'client': client,
      'address': address,
      'city': city,
      'region': region,
      'distributor': distributor,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      client: map['client'],
      address: map['address'],
      city: map['city'],
      region: map['region'],
      distributor: map['distributor'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}