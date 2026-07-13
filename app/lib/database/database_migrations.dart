import 'package:sqflite/sqflite.dart';

import 'database_tables.dart';

class DatabaseMigrations {
  DatabaseMigrations._();

  static const currentVersion = 1;

  static Future<void> onCreate(
      Database db,
      int version,
      ) async {
    await db.execute(DatabaseTables.projects);
    await db.execute(DatabaseTables.circuits);
    await db.execute(DatabaseTables.panels);
    await db.execute(DatabaseTables.feeders);
  }

  static Future<void> onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    // Futuras migraciones
  }

  static Future<void> onDowngrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    // Sin soporte por ahora
  }
}