class ElectricalAnalysis {
  final double? voltage;
  final double? current;
  final double? resistance;
  final double? power;

  final String title;
  final String formula;
  final String explanation;
  final String technicalNote;

  const ElectricalAnalysis({
    this.voltage,
    this.current,
    this.resistance,
    this.power,
    required this.title,
    required this.formula,
    required this.explanation,
    required this.technicalNote,
  });
}