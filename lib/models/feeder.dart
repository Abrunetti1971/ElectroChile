class Feeder {
  final String id;
  final String projectId;

  // Identificación
  final int number;
  final String name;
  final String origin;
  final String destination;

  // Datos eléctricos
  final double voltage;
  final int phases;
  final double installedPower;
  final double demandPower;
  final double current;
  final double demandFactor;
  final double powerFactor;

  // Instalación
  final double length;
  final String conductorMaterial;
  final double conductorSection;
  final int activeConductors;
  final double earthSection;
  final String conduit;
  final String protection;

  // Verificación
  final double voltageDropPercent;
  final String status;
  final String notes;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Feeder({
    required this.id,
    required this.projectId,
    this.number = 1,
    required this.name,
    this.origin = 'Empalme',
    this.destination = 'Tablero General',
    required this.voltage,
    this.phases = 1,
    required this.installedPower,
    required this.demandPower,
    required this.current,
    this.demandFactor = 1.0,
    this.powerFactor = 1.0,
    required this.length,
    required this.conductorMaterial,
    required this.conductorSection,
    this.activeConductors = 2,
    this.earthSection = 0,
    this.conduit = '',
    required this.protection,
    this.voltageDropPercent = 0,
    this.status = 'OK',
    this.notes = '',
    required this.createdAt,
    required this.updatedAt,
  });

  Feeder copyWith({
    String? id,
    String? projectId,
    int? number,
    String? name,
    String? origin,
    String? destination,
    double? voltage,
    int? phases,
    double? installedPower,
    double? demandPower,
    double? current,
    double? demandFactor,
    double? powerFactor,
    double? length,
    String? conductorMaterial,
    double? conductorSection,
    int? activeConductors,
    double? earthSection,
    String? conduit,
    String? protection,
    double? voltageDropPercent,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Feeder(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      number: number ?? this.number,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      voltage: voltage ?? this.voltage,
      phases: phases ?? this.phases,
      installedPower: installedPower ?? this.installedPower,
      demandPower: demandPower ?? this.demandPower,
      current: current ?? this.current,
      demandFactor: demandFactor ?? this.demandFactor,
      powerFactor: powerFactor ?? this.powerFactor,
      length: length ?? this.length,
      conductorMaterial:
          conductorMaterial ?? this.conductorMaterial,
      conductorSection:
          conductorSection ?? this.conductorSection,
      activeConductors:
          activeConductors ?? this.activeConductors,
      earthSection: earthSection ?? this.earthSection,
      conduit: conduit ?? this.conduit,
      protection: protection ?? this.protection,
      voltageDropPercent:
          voltageDropPercent ?? this.voltageDropPercent,
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
      'origin': origin,
      'destination': destination,
      'voltage': voltage,
      'phases': phases,
      'installed_power': installedPower,
      'demand_power': demandPower,
      'current': current,
      'demand_factor': demandFactor,
      'power_factor': powerFactor,
      'length': length,
      'conductor_material': conductorMaterial,
      'conductor_section': conductorSection,
      'active_conductors': activeConductors,
      'earth_section': earthSection,
      'conduit': conduit,
      'protection': protection,
      'voltage_drop_percent': voltageDropPercent,
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Feeder.fromMap(Map<String, dynamic> map) {
    return Feeder(
      id: map['id'] as String,
      projectId: map['project_id'] as String,
      number: (map['number'] ?? 1) as int,
      name: map['name'] as String,
      origin: (map['origin'] ?? 'Empalme') as String,
      destination:
          (map['destination'] ?? 'Tablero General') as String,
      voltage: (map['voltage'] as num).toDouble(),
      phases: (map['phases'] ?? 1) as int,
      installedPower:
          (map['installed_power'] as num).toDouble(),
      demandPower: (map['demand_power'] as num).toDouble(),
      current: (map['current'] as num).toDouble(),
      demandFactor:
          ((map['demand_factor'] ?? 1.0) as num).toDouble(),
      powerFactor:
          ((map['power_factor'] ?? 1.0) as num).toDouble(),
      length: (map['length'] as num).toDouble(),
      conductorMaterial:
          map['conductor_material'] as String,
      conductorSection:
          (map['conductor_section'] as num).toDouble(),
      activeConductors:
          (map['active_conductors'] ?? 2) as int,
      earthSection:
          ((map['earth_section'] ?? 0) as num).toDouble(),
      conduit: (map['conduit'] ?? '') as String,
      protection: map['protection'] as String,
      voltageDropPercent:
          ((map['voltage_drop_percent'] ?? 0) as num)
              .toDouble(),
      status: (map['status'] ?? 'OK') as String,
      notes: (map['notes'] ?? '') as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
