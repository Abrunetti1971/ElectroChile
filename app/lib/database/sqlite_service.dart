import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteService {
SQLiteService._();

static final SQLiteService instance =
SQLiteService._();

static Database? _database;

//--------------------------------------------------
// Obtener instancia
//--------------------------------------------------

Future<Database> get database async {

if (_database != null) {
return _database!;
}

_database = await _initDatabase();

return _database!;
}

//--------------------------------------------------
// Crear Base de Datos
//--------------------------------------------------

Future<Database> _initDatabase() async {

final databasePath =
await getDatabasesPath();

final path = join(
databasePath,
"electrochile.db",
);

return await openDatabase(

path,

version: 1,

onCreate: _onCreate,

);
}

//--------------------------------------------------
// Crear tablas
//--------------------------------------------------

Future<void> _onCreate(

Database db,

int version,

) async {

await db.execute('''
          CREATE TABLE projects(

        id TEXT PRIMARY KEY,

        nombre TEXT NOT NULL,

        fecha TEXT NOT NULL,

        tipo TEXT NOT NULL,

        voltaje REAL NOT NULL,

        corriente REAL NOT NULL,

        longitud REAL NOT NULL,

        material TEXT NOT NULL,

        sistema TEXT NOT NULL,

        conductorAmpacidad REAL NOT NULL,

        conductorFinal REAL NOT NULL,

        proteccion INTEGER NOT NULL,

        diferencial TEXT NOT NULL,

        caidaVolt REAL NOT NULL,

        caidaPorcentaje REAL NOT NULL,

        cumple INTEGER NOT NULL,

        observacion TEXT NOT NULL

      )

    ''');

}

  //--------------------------------------------------
  // Cerrar Base de Datos
  //--------------------------------------------------

  Future<void> close() async {

    final db = await database;

    await db.close();

    _database = null;

  }

}
