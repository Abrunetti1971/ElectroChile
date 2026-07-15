class GroupingFactorRow {

  final int circuits;

  final double factor;

  const GroupingFactorRow({

    required this.circuits,

    required this.factor,

  });

}

class GroupingTable {

GroupingTable._();

static const List<GroupingFactorRow> rows = [

GroupingFactorRow(

circuits: 1,

factor: 1.00,

),

GroupingFactorRow(

circuits: 2,

factor: 0.80,

),

GroupingFactorRow(

circuits: 3,

factor: 0.70,

),
  GroupingFactorRow(

    circuits: 4,

    factor: 0.65,

  ),

  GroupingFactorRow(

    circuits: 5,

    factor: 0.60,

  ),

];

}