enum ElectricalSystem {
  singlePhase,
  threePhase,
}

enum ConductorMaterial {
  copper,
  aluminum,
}

enum InstallationMethod {
  embeddedDuct,
  surfaceDuct,
  cableTray,
  buried,
}

enum LoadInputMode {
  power,
  current,
}

class CircuitDesignInput {
  final LoadInputMode inputMode;
  final ElectricalSystem system;
  final ConductorMaterial conductorMaterial;
  final InstallationMethod installationMethod;

  final double voltage;
  final double loadValue;
  final double lengthMeters;
  final double powerFactor;
  final double efficiency;
  final double maximumVoltageDropPercent;

  final int activeConductors;
  final double ambientTemperatureCelsius;

  const CircuitDesignInput({
    required this.inputMode,
    required this.system,
    required this.conductorMaterial,
    required this.installationMethod,
    required this.voltage,
    required this.loadValue,
    required this.lengthMeters,
    this.powerFactor = 1.0,
    this.efficiency = 1.0,
    this.maximumVoltageDropPercent = 3.0,
    this.activeConductors = 2,
    this.ambientTemperatureCelsius = 30.0,
  });

  bool get isSinglePhase => system == ElectricalSystem.singlePhase;

  bool get isThreePhase => system == ElectricalSystem.threePhase;

  bool get isCopper => conductorMaterial == ConductorMaterial.copper;

  bool get usesPowerInput => inputMode == LoadInputMode.power;

  CircuitDesignInput copyWith({
    LoadInputMode? inputMode,
    ElectricalSystem? system,
    ConductorMaterial? conductorMaterial,
    InstallationMethod? installationMethod,
    double? voltage,
    double? loadValue,
    double? lengthMeters,
    double? powerFactor,
    double? efficiency,
    double? maximumVoltageDropPercent,
    int? activeConductors,
    double? ambientTemperatureCelsius,
  }) {
    return CircuitDesignInput(
      inputMode: inputMode ?? this.inputMode,
      system: system ?? this.system,
      conductorMaterial: conductorMaterial ?? this.conductorMaterial,
      installationMethod: installationMethod ?? this.installationMethod,
      voltage: voltage ?? this.voltage,
      loadValue: loadValue ?? this.loadValue,
      lengthMeters: lengthMeters ?? this.lengthMeters,
      powerFactor: powerFactor ?? this.powerFactor,
      efficiency: efficiency ?? this.efficiency,
      maximumVoltageDropPercent:
      maximumVoltageDropPercent ?? this.maximumVoltageDropPercent,
      activeConductors: activeConductors ?? this.activeConductors,
      ambientTemperatureCelsius:
      ambientTemperatureCelsius ?? this.ambientTemperatureCelsius,
    );
  }
}