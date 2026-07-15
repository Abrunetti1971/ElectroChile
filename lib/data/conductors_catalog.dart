class ConductorData {
  final double section;
  final int maxCurrent;

  const ConductorData({
    required this.section,
    required this.maxCurrent,
  });
}

class ConductorsCatalog {
  ConductorsCatalog._();

  static const List<ConductorData> copperPVC = [

    ConductorData(
      section: 1.5,
      maxCurrent: 13,
    ),

    ConductorData(
      section: 2.5,
      maxCurrent: 18,
    ),

    ConductorData(
      section: 4.0,
      maxCurrent: 24,
    ),

    ConductorData(
      section: 6.0,
      maxCurrent: 31,
    ),

    ConductorData(
      section: 10.0,
      maxCurrent: 43,
    ),

    ConductorData(
      section: 16.0,
      maxCurrent: 57,
    ),

    ConductorData(
      section: 25.0,
      maxCurrent: 76,
    ),

    ConductorData(
      section: 35.0,
      maxCurrent: 96,
    ),

    ConductorData(
      section: 50.0,
      maxCurrent: 119,
    ),

    ConductorData(
      section: 70.0,
      maxCurrent: 151,
    ),

    ConductorData(
      section: 95.0,
      maxCurrent: 182,
    ),
  ];
}