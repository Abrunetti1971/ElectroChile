import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/feeder.dart';
import 'app_database.dart';

class FeederDao {
  FeederDao._();

  static final FeederDao instance = FeederDao._();

  Future<List<Feeder>> getByProject(String projectId) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'feeders',
      where: 'project_id = ?',
      whereArgs: [projectId],
      orderBy: 'number ASC, name ASC',
    );

    debugPrint('Alimentadores encontrados: ${result.length}');

    return result.map(Feeder.fromMap).toList();
  }

  Future<Feeder?> getById(String id) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'feeders',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return Feeder.fromMap(result.first);
  }

  Future<void> insert(Feeder feeder) async {
    final db = await AppDatabase.instance.database;

    await db.insert(
      'feeders',
      feeder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('Alimentador agregado: ${feeder.name}');
  }

  Future<void> update(Feeder feeder) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      'feeders',
      feeder.toMap(),
      where: 'id = ?',
      whereArgs: [feeder.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;

    await db.delete(
      'feeders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> countByProject(String projectId) async {
    final db = await AppDatabase.instance.database;

    final result = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT COUNT(*) FROM feeders WHERE project_id = ?',
        [projectId],
      ),
    );

    return result ?? 0;
  }

  Future<int> nextFeederNumber(String projectId) async {
    final db = await AppDatabase.instance.database;

    final result = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT MAX(number) FROM feeders WHERE project_id = ?',
        [projectId],
      ),
    );

    return result == null ? 1 : result + 1;
  }
}
