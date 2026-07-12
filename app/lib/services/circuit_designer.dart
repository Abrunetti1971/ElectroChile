import '../models/circuit_design_input.dart';
import '../models/circuit_design_result.dart';
import 'electrical_calculator.dart';

class CircuitDesigner {
  CircuitDesigner._();

  static CircuitDesignResult design(
      CircuitDesignInput input,
      ) {
    //--------------------------------------------------
    // 1. Calcular corriente
    //--------------------------------------------------

    double current;

    if (input.usesPowerInput) {
      if (input.isSinglePhase) {
        current = ElectricalCalculator.monoCurrent(
          watts: input.loadValue,
          voltage: input.voltage,
        );
      } else {
        current = ElectricalCalculator.threePhaseCurrent(
          watts: input.loadValue,
          voltage: input.voltage,
          fp: input.powerFactor,
        );
      }
    } else {
      current = input.loadValue;
    }

    //--------------------------------------------------
    // 2. Selección inicial de conductor
    // (Primera versión. Luego será reemplazada por tablas RIC.)
    //--------------------------------------------------

    double section;

    if (current <= 10) {
      section = 1.5;
    } else if (current <= 20) {
      section = 2.5;
    } else if (current <= 25) {
      section = 4;
    } else if (current <= 32) {
      section = 6;
    } else if (current <= 40) {
      section = 10;
    } else if (current <= 63) {
      section = 16;
    } else {
      section = 25;
    }

    //--------------------------------------------------
    // 3. Disyuntor sugerido
    //--------------------------------------------------

    int breaker;

    if (current <= 10) {
      breaker = 10;
    } else if (current <= 16) {
      breaker = 16;
    } else if (current <= 20) {
      breaker = 20;
    } else if (current <= 25) {
      breaker = 25;
    } else if (current <= 32) {
      breaker = 32;
    } else if (current <= 40) {
      breaker = 40;
    } else if (current <= 50) {
      breaker = 50;
    } else {
      breaker = 63;
    }

    //--------------------------------------------------
    // 4. Diferencial sugerido
    //--------------------------------------------------

    int rcd = breaker >= 40 ? 40 : 25;

    //--------------------------------------------------
    // 5. Canalización (provisional)
    //--------------------------------------------------

    String conduit;

    if (section <= 2.5) {
      conduit = "EMT 20 mm";
    } else if (section <= 10) {
      conduit = "EMT 25 mm";
    } else {
      conduit = "EMT 32 mm";
    }

    //--------------------------------------------------
    // 6. Caída de tensión
    // (Modelo simplificado inicial)
    //--------------------------------------------------

    double voltageDropVolts =
        (2 * input.lengthMeters * current * 0.018) / section;

    double voltageDropPercent =
        (voltageDropVolts / input.voltage) * 100;

    //--------------------------------------------------
    // 7. Observaciones
    //--------------------------------------------------

    List<String> observations = [];

    if (voltageDropPercent <= input.maximumVoltageDropPercent) {
      observations.add(
          "✔ La caída de tensión está dentro del límite establecido.");
    } else {
      observations.add(
          "⚠ La caída de tensión supera el límite definido.");
    }

    observations.add(
        "⚠ Selección preliminar. En versiones futuras se aplicarán tablas oficiales del RIC para capacidad de conducción, temperatura, agrupamiento y método de instalación.");

    //--------------------------------------------------

    return CircuitDesignResult(
      current: current,
      recommendedSection: section,
      voltageDropPercent: voltageDropPercent,
      voltageDropVolts: voltageDropVolts,
      recommendedBreaker: breaker,
      recommendedRcd: rcd,
      conduit: conduit,
      complies: voltageDropPercent <=
          input.maximumVoltageDropPercent,
      observations: observations,
    );
  }
}