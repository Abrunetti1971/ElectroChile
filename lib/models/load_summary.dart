class LoadCircuit {
  final String name;
  final String type;

  final double power;
  final double current;

  final double conductorSection;

  final int breaker;

  const LoadCircuit({
    required this.name,
    required this.type,
    required this.power,
    required this.current,
    required this.conductorSection,
    required this.breaker,
  });
}

class LoadSummary {
  final List<LoadCircuit> circuits;

  final double installedPower;

  final double demandPower;

  final double totalCurrent;

  final double feederSection;

  final int mainBreaker;

  final String differential;

  final String recommendedService;

  const LoadSummary({
    required this.circuits,
    required this.installedPower,
    required this.demandPower,
    required this.totalCurrent,
    required this.feederSection,
    required this.mainBreaker,
    required this.differential,
    required this.recommendedService,
  });

  bool get hasCircuits => circuits.isNotEmpty;

  int get circuitsCount => circuits.length;
}