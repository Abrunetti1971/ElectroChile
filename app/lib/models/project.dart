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
    this.city = '',
    this.region = '',
    this.distributor = '',
    this.notes = '',
    required this.createdAt,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? createdAt;

  /// Crea una copia del proyecto modificando únicamente
  /// los campos indicados.
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

  /// Convierte el proyecto a un mapa.
  ///
  /// Este método se utilizará posteriormente para SQLite,
  /// exportación e importación de proyectos.
  Map<String, Object?> toMap() {
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

  /// Construye un proyecto desde un mapa proveniente
  /// de SQLite, JSON u otra fuente de datos.
  factory Project.fromMap(Map<String, Object?> map) {
    final createdAt = _parseDate(
      map['created_at'],
      fallback: DateTime.now(),
    );

    return Project(
      id: _readString(map['id']),
      name: _readString(map['name']),
      client: _readString(map['client']),
      address: _readString(map['address']),
      city: _readString(map['city']),
      region: _readString(map['region']),
      distributor: _readString(map['distributor']),
      notes: _readString(map['notes']),
      createdAt: createdAt,
      updatedAt: _parseDate(
        map['updated_at'],
        fallback: createdAt,
      ),
    );
  }

  /// Indica si el proyecto tiene los datos mínimos válidos.
  bool get isValid {
    return id.trim().isNotEmpty && name.trim().isNotEmpty;
  }

  /// Dirección completa preparada para mostrar en pantalla.
  String get fullAddress {
    final parts = <String>[
      address.trim(),
      city.trim(),
      region.trim(),
    ].where((part) => part.isNotEmpty).toList();

    if (parts.isEmpty) {
      return 'Dirección no especificada';
    }

    return parts.join(', ');
  }

  /// Cliente preparado para mostrar en pantalla.
  String get clientDisplay {
    return client.trim().isEmpty ? 'Cliente no especificado' : client.trim();
  }

  /// Distribuidora preparada para mostrar en pantalla.
  String get distributorDisplay {
    return distributor.trim().isEmpty
        ? 'Distribuidora no especificada'
        : distributor.trim();
  }

  /// Convierte cualquier valor compatible en texto.
  static String _readString(Object? value) {
    return value?.toString().trim() ?? '';
  }

  /// Convierte una fecha guardada como String o DateTime.
  static DateTime _parseDate(
      Object? value, {
        required DateTime fallback,
      }) {
    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value) ?? fallback;
    }

    return fallback;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Project &&
            runtimeType == other.runtimeType &&
            id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Project('
        'id: $id, '
        'name: $name, '
        'client: $client, '
        'address: $fullAddress'
        ')';
  }
}