enum CircuitType {
  lighting,
  outlets,
  kitchen,
  airConditioner,
  waterPump,
  electricGate,
  electricOven,
  waterHeater,
  motor,
  other,
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

  final double conductorSection;

  final String conductorMaterial;

  final int breaker;

  final int differential;

  final String conduit;

  final double voltageDrop;

  final bool complies;

  final List<String> observations;

  const Circuit({
    required this.id,
    required this.projectId,
    required this.name,
    required this.type,
    required this.voltage,
    required this.power,
    required this.current,
    required this.length,
    required this.conductorSection,
    required this.conductorMaterial,
    required this.breaker,
    required this.differential,
    required this.conduit,
    required this.voltageDrop,
    required this.complies,
    required this.observations,
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
    double? conductorSection,
    String? conductorMaterial,
    int? breaker,
    int? differential,
    String? conduit,
    double? voltageDrop,
    bool? complies,
    List<String>? observations,
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
      conductorSection: conductorSection ?? this.conductorSection,
      conductorMaterial: conductorMaterial ?? this.conductorMaterial,
      breaker: breaker ?? this.breaker,
      differential: differential ?? this.differential,
      conduit: conduit ?? this.conduit,
      voltageDrop: voltageDrop ?? this.voltageDrop,
      complies: complies ?? this.complies,
      observations: observations ?? this.observations,
    );
  }
}