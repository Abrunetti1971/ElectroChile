enum CircuitType {
  lighting,
  outlets,
  kitchen,
  oven,
  waterHeater,
  airConditioner,
  pump,
  motor,
  gate,
  special,
}

class Circuit {
  final String id;

  final String projectId;

  final String name;

  final CircuitType type;

  final double voltage;

  final double power;

  final double current;

  final double length;

  final String conductor;

  final String breaker;

  final String differential;

  final double voltageDrop;

  final String observations;

  const Circuit({
    required this.id,
    required this.projectId,
    required this.name,
    required this.type,
    required this.voltage,
    required this.power,
    required this.current,
    required this.length,
    required this.conductor,
    required this.breaker,
    required this.differential,
    required this.voltageDrop,
    this.observations = '',
  });

  Circuit copyWith({
    String? id,
    String? projectId,
    String? name,
    CircuitType? type,
    double? voltage,
    double? power,
    double? current,
    double? length,
    String? conductor,
    String? breaker,
    String? differential,
    double? voltageDrop,
    String? observations,
  }) {
    return Circuit(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      type: type ?? this.type,
      voltage: voltage ?? this.voltage,
      power: power ?? this.power,
      current: current ?? this.current,
      length: length ?? this.length,
      conductor: conductor ?? this.conductor,
      breaker: breaker ?? this.breaker,
      differential: differential ?? this.differential,
      voltageDrop: voltageDrop ?? this.voltageDrop,
      observations: observations ?? this.observations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'name': name,
      'type': type.index,
      'voltage': voltage,
      'power': power,
      'current': current,
      'length': length,
      'conductor': conductor,
      'breaker': breaker,
      'differential': differential,
      'voltageDrop': voltageDrop,
      'observations': observations,
    };
  }

  factory Circuit.fromMap(Map<String, dynamic> map) {
    return Circuit(
      id: map['id'],
      projectId: map['projectId'],
      name: map['name'],
      type: CircuitType.values[map['type']],
      voltage: (map['voltage'] as num).toDouble(),
      power: (map['power'] as num).toDouble(),
      current: (map['current'] as num).toDouble(),
      length: (map['length'] as num).toDouble(),
      conductor: map['conductor'],
      breaker: map['breaker'],
      differential: map['differential'],
      voltageDrop: (map['voltageDrop'] as num).toDouble(),
      observations: map['observations'] ?? '',
    );
  }

  String get typeName {
    switch (type) {
      case CircuitType.lighting:
        return 'Alumbrado';

      case CircuitType.outlets:
        return 'Enchufes';

      case CircuitType.kitchen:
        return 'Cocina';

      case CircuitType.oven:
        return 'Horno';

      case CircuitType.waterHeater:
        return 'Termo';

      case CircuitType.airConditioner:
        return 'Climatización';

      case CircuitType.pump:
        return 'Bomba';

      case CircuitType.motor:
        return 'Motor';

      case CircuitType.gate:
        return 'Portón';

      case CircuitType.special:
        return 'Especial';
    }
  }
}