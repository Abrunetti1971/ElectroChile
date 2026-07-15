import 'package:sqflite/sqflite.dart';

import 'database_tables.dart';

class DatabaseMigrations {
  DatabaseMigrations._();

  // 1: projects
  // 2: circuits
  // 3: ampliación técnica de circuits
  static const int currentVersion = 3;

  static Future<void> onCreate(
      Database db,
      int version,
      ) async {
    await db.transaction((txn) async {
      await txn.execute(DatabaseTables.projects);
      await txn.execute(DatabaseTables.circuits);
    });
  }

  static Future<void> onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    await db.transaction((txn) async {
      if (oldVersion < 2) {
        await txn.execute(DatabaseTables.circuits);
      }

      if (oldVersion < 3) {
        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'number',
          definition: 'INTEGER NOT NULL DEFAULT 1',
        );

        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'phases',
          definition: 'INTEGER NOT NULL DEFAULT 1',
        );

        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'power_factor',
          definition: 'REAL NOT NULL DEFAULT 1.0',
        );

        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'demand_factor',
          definition: 'REAL NOT NULL DEFAULT 1.0',
        );

        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'conduit',
          definition: "TEXT NOT NULL DEFAULT ''",
        );

        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'differential',
          definition: "TEXT NOT NULL DEFAULT ''",
        );

        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'earth',
          definition: "TEXT NOT NULL DEFAULT ''",
        );

        await _addColumnIfMissing(
          txn,
          table: 'circuits',
          column: 'status',
          definition: "TEXT NOT NULL DEFAULT 'OK'",
        );
      }
    });
  }

  static Future<void> _addColumnIfMissing(
      DatabaseExecutor db, {
        required String table,
        required String column,
        required String definition,
      }) async {
    final columns = await db.rawQuery(
      'PRAGMA table_info($table)',
    );

    final exists = columns.any(
          (item) => item['name'] == column,
    );

    if (exists) {
      return;
    }

    await db.execute(
      'ALTER TABLE $table ADD COLUMN $column $definition',
    );
  }

  static Future<void> onDowngrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    await db.transaction((txn) async {
      await txn.execute(
        'DROP TABLE IF EXISTS circuits',
      );

      await txn.execute(
        'DROP TABLE IF EXISTS projects',
      );
    });

    await onCreate(
      db,
      currentVersion,
    );
  }
}