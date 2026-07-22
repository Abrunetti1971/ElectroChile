enum ConductorMaterial { copper, aluminum }

class ConductorResistivity {
  static double value(ConductorMaterial material){
    switch(material){
      case ConductorMaterial.copper: return 0.0175;
      case ConductorMaterial.aluminum: return 0.0282;
    }
  }
}
