class ElectricalResult {
  final double? voltage;
  final double? current;
  final double? resistance;
  final double? power;

  final String calculatedValue;
  final String formula;

  const ElectricalResult({
    this.voltage,
    this.current,
    this.resistance,
    this.power,
    required this.calculatedValue,
    required this.formula,
  });
}