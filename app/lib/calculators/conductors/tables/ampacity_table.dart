class AmpacityRow {

  final double section;

  final int pvc;

  final int xlpe;

  final int aluminium;

  const AmpacityRow({

    required this.section,

    required this.pvc,

    required this.xlpe,

    required this.aluminium,

  });

}

class AmpacityTable {

  AmpacityTable._();

  static const List<AmpacityRow> rows = [

    AmpacityRow(
      section: 1.5,
      pvc: 18,
      xlpe: 22,
      aluminium: 15,
    ),

    AmpacityRow(
      section: 2.5,
      pvc: 24,
      xlpe: 30,
      aluminium: 21,
    ),

    AmpacityRow(
      section: 4,
      pvc: 32,
      xlpe: 39,
      aluminium: 28,
    ),

    AmpacityRow(
      section: 6,
      pvc: 41,
      xlpe: 50,
      aluminium: 36,
    ),

    AmpacityRow(
      section: 10,
      pvc: 57,
      xlpe: 68,
      aluminium: 50,
    ),

    AmpacityRow(
      section: 16,
      pvc: 76,
      xlpe: 91,
      aluminium: 68,
    ),

    AmpacityRow(
      section: 25,
      pvc: 101,
      xlpe: 119,
      aluminium: 89,
    ),

    AmpacityRow(
      section: 35,
      pvc: 125,
      xlpe: 147,
      aluminium: 110,
    ),

    AmpacityRow(
      section: 50,
      pvc: 151,
      xlpe: 176,
      aluminium: 134,
    ),

    AmpacityRow(
      section: 70,
      pvc: 192,
      xlpe: 222,
      aluminium: 171,
    ),

    AmpacityRow(
      section: 95,
      pvc: 232,
      xlpe: 269,
      aluminium: 207,
    ),

    AmpacityRow(
      section: 120,
      pvc: 269,
      xlpe: 312,
      aluminium: 239,
    ),

    AmpacityRow(
      section: 150,
      pvc: 309,
      xlpe: 358,
      aluminium: 275,
    ),

    AmpacityRow(
      section: 185,
      pvc: 353,
      xlpe: 408,
      aluminium: 314,
    ),

    AmpacityRow(
      section: 240,
      pvc: 415,
      xlpe: 478,
      aluminium: 370,
    ),

  ];

}