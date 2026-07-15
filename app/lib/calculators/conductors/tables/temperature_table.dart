class TemperatureFactorRow {

  final int temperature;

  final double factor;

  const TemperatureFactorRow({

    required this.temperature,

    required this.factor,

  });

}

class TemperatureTable {

TemperatureTable._();

static const List<TemperatureFactorRow> rows = [

TemperatureFactorRow(

temperature: 25,

factor: 1.03,

),

TemperatureFactorRow(

temperature: 30,

factor: 1.00,

),

TemperatureFactorRow(

temperature: 35,

factor: 0.94,

),
  TemperatureFactorRow(

    temperature: 40,

    factor: 0.87,

  ),

  TemperatureFactorRow(

    temperature: 45,

    factor: 0.79,

  ),

  TemperatureFactorRow(

    temperature: 50,

    factor: 0.71,

  ),

];

}