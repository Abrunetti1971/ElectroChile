class VoltageDropResult{
  final double volts;
  final double percent;
  final bool complies;
  final double limit;

  const VoltageDropResult({
    required this.volts,
    required this.percent,
    required this.complies,
    required this.limit,
  });
}
