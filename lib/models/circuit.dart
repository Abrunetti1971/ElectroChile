class Circuit {
  final String id;
  final String projectId;

  // Identificación
  final int number;
  final String name;
  final String type;

  // Datos eléctricos
  final double voltage;
  final int phases;

  final double power;
  final double current;

  final double powerFactor;
  final double demandFactor;

  // Instalación
  final double length;

  final String conductorMaterial;
  final double conductorSection;

  final String conduit;

  final String protection;
  final String differential;
  final String earth;

  final String status;

  final String notes;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Circuit({
    required this.id,
    required this.projectId,

    this.number = 1,

    required this.name,
    required this.type,

    required this.voltage,
    this.phases = 1,

    required this.power,
    required this.current,

    this.powerFactor = 1.0,
    this.demandFactor = 1.0,

    required this.length,

    required this.conductorMaterial,
    required this.conductorSection,

    this.conduit = '',

    required this.protection,

    this.differential = '',
    this.earth = '',

    this.status = 'OK',

    required this.notes,

    required this.createdAt,
    required this.updatedAt,
  });

  Circuit copyWith({
    String? id,
    String? projectId,

    int? number,

    String? name,
    String? type,

    double? voltage,
    int? phases,

    double? power,
    double? current,

    double? powerFactor,
    double? demandFactor,

    double? length,

    String? conductorMaterial,
    double? conductorSection,

    String? conduit,

    String? protection,
    String? differential,
    String? earth,

    String? status,

    String? notes,

    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Circuit(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,

      number: number ?? this.number,

      name: name ?? this.name,
      type: type ?? this.type,

      voltage: voltage ?? this.voltage,
      phases: phases ?? this.phases,

      power: power ?? this.power,
      current: current ?? this.current,

      powerFactor: powerFactor ?? this.powerFactor,
      demandFactor: demandFactor ?? this.demandFactor,

      length: length ?? this.length,

      conductorMaterial:
      conductorMaterial ?? this.conductorMaterial,

      conductorSection:
      conductorSection ?? this.conductorSection,

      conduit: conduit ?? this.conduit,

      protection: protection ?? this.protection,

      differential:
      differential ?? this.differential,

      earth: earth ?? this.earth,

      status: status ?? this.status,

      notes: notes ?? this.notes,

      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'project_id': projectId,

      'number': number,

      'name': name,
      'type': type,

      'voltage': voltage,
      'phases': phases,

      'power': power,
      'current': current,

      'power_factor': powerFactor,
      'demand_factor': demandFactor,

      'length': length,

      'conductor_material': conductorMaterial,
      'conductor_section': conductorSection,

      'conduit': conduit,

      'protection': protection,

      'differential': differential,
      'earth': earth,

      'status': status,

      'notes': notes,

      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Circuit.fromMap(Map<String, dynamic> map) {
    return Circuit(
      id: map['id'],

      projectId: map['project_id'],

      number: map['number'] ?? 1,

      name: map['name'],

      type: map['type'],

      voltage: (map['voltage'] as num).toDouble(),

      phases: map['phases'] ?? 1,

      power: (map['power'] as num).toDouble(),

      current: (map['current'] as num).toDouble(),

      powerFactor:
      ((map['power_factor'] ?? 1.0) as num).toDouble(),

      demandFactor:
      ((map['demand_factor'] ?? 1.0) as num).toDouble(),

      length: (map['length'] as num).toDouble(),

      conductorMaterial:
      map['conductor_material'],

      conductorSection:
      (map['conductor_section'] as num).toDouble(),

      conduit: map['conduit'] ?? '',

      protection: map['protection'],

      differential: map['differential'] ?? '',

      earth: map['earth'] ?? '',

      status: map['status'] ?? 'OK',

      notes: map['notes'],

      createdAt: DateTime.parse(map['created_at']),

      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}