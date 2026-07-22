import 'ampacity_service.dart';
import 'protection_service.dart';
import 'voltage_drop_service.dart';

class CircuitSizingResult {
  final double current;

  final int breaker;

  final double conductorSection;

  final double ampacity;

  final double voltageDrop;

  final double voltageDropPercent;

  final bool ampacityOk;

  final bool voltageDropOk;

  final bool complies;

  const CircuitSizingResult({
    required this.current,
    required this.breaker,
    required this.conductorSection,
    required this.ampacity,
    required this.voltageDrop,
    required this.voltageDropPercent,
    required this.ampacityOk,
    required this.voltageDropOk,
    required this.complies,
  });
}

class CircuitSizingService {
  const CircuitSizingService();

  final AmpacityService _ampacity =
  const AmpacityService();

  final ProtectionService _protection =
  const ProtectionService();

  final VoltageDropService _voltageDrop =
  const VoltageDropService();

  CircuitSizingResult calculate({
    required double power,
    required double voltage,
    required double length,
    required String material,
    required int phases,
  }) {
    final current = power / voltage;

    final breaker =
    _protection.recommendedBreaker(current);

    final section =
    _ampacity.minimumSection(current);

    final ampacity =
    _ampacity.currentCapacity(section);

    final vd =
    _voltageDrop.validate(
      voltage: voltage,
      current: current,
      length: length,
      section: section,
      material: material,
      phases: phases,
    );

    return CircuitSizingResult(
      current: current,
      breaker: breaker,
      conductorSection: section,
      ampacity: ampacity,
      voltageDrop: vd.voltageDrop,
      voltageDropPercent: vd.voltageDropPercent,
      ampacityOk: current <= ampacity,
      voltageDropOk: vd.complies,
      complies:
      current <= ampacity &&
          vd.complies,
    );
  }
}