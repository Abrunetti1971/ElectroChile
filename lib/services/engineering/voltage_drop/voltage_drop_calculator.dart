import 'conductor_resistivity.dart';
import 'voltage_drop_limits.dart';
import 'voltage_drop_result.dart';

class VoltageDropCalculator{
  static VoltageDropResult calculate({
    required double voltage,
    required double current,
    required double length,
    required double section,
    required ConductorMaterial material,
    bool threePhase=false,
    bool lighting=true,
  }){
    final rho=ConductorResistivity.value(material);

    final drop=threePhase
      ? (1.732*length*current*rho)/section
      : (2*length*current*rho)/section;

    final percent=(drop/voltage)*100;
    final limit=lighting
      ? VoltageDropLimits.lighting
      : VoltageDropLimits.power;

    return VoltageDropResult(
      volts:drop,
      percent:percent,
      complies:percent<=limit,
      limit:limit,
    );
  }
}
