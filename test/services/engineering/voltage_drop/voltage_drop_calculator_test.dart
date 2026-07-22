import 'package:flutter_test/flutter_test.dart';
import 'package:electrochile_pro/services/engineering/voltage_drop/conductor_resistivity.dart';
import 'package:electrochile_pro/services/engineering/voltage_drop/voltage_drop_calculator.dart';

void main(){
  test('Voltage drop calculation', (){
    final r=VoltageDropCalculator.calculate(
      voltage:220,
      current:10,
      length:20,
      section:2.5,
      material:ConductorMaterial.copper,
    );
    expect(r.percent>0,true);
  });
}
