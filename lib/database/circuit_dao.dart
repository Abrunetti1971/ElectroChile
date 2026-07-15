import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/circuit.dart';
import 'app_database.dart';

class CircuitDao {
  CircuitDao._();

  static final CircuitDao instance = CircuitDao._();

  //=========================================================
  // OBTENER CIRCUITOS DE UN PROYECTO
  //=========================================================

  Future<List<Circuit>> getByProject(
      String projectId,
      ) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'circuits',
      where: 'project_id = ?',
      whereArgs: [projectId],
      orderBy: 'number ASC, name ASC',
    );

    debugPrint(
      'Circuitos encontrados: ${result.length}',
    );

    return result.map(Circuit.fromMap).toList();
  }

  //=========================================================
  // OBTENER UN CIRCUITO
  //=========================================================

  Future<Circuit?> getById(
      String id,
      ) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'circuits',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Circuit.fromMap(result.first);
  }

  //=========================================================
  // INSERTAR
  //=========================================================

  Future<void> insert(
      Circuit circuit,
      ) async {
    final db = await AppDatabase.instance.database;

    await db.insert(
      'circuits',
      circuit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint(
      'Circuito agregado: ${circuit.name}',
    );
  }

  //=========================================================
  // ACTUALIZAR
  //=========================================================

  Future<void> update(
      Circuit circuit,
      ) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      'circuits',
      circuit.toMap(),
      where: 'id = ?',
      whereArgs: [circuit.id],
    );

    debugPrint(
      'Circuito actualizado: ${circuit.name}',
    );
  }

  //=========================================================
  // ELIMINAR
  //=========================================================

  Future<void> delete(
      String id,
      ) async {
    final db = await AppDatabase.instance.database;

    await db.delete(
      'circuits',
      where: 'id = ?',
      whereArgs: [id],
    );

    debugPrint(
      'Circuito eliminado',
    );
  }

  //=========================================================
  // CONTAR CIRCUITOS
  //=========================================================

  Future<int> countByProject(
      String projectId,
      ) async {
    final db = await AppDatabase.instance.database;

    final result = Sqflite.firstIntValue(
      await db.rawQuery(
        '''
        SELECT COUNT(*)
        FROM circuits
        WHERE project_id = ?
        ''',
        [projectId],
      ),
    );

    return result ?? 0;
  }

  //=========================================================
  // OBTENER SIGUIENTE NÚMERO
  //=========================================================

  Future<int> nextCircuitNumber(
      String projectId,
      ) async {
    final db = await AppDatabase.instance.database;

    final result = Sqflite.firstIntValue(
      await db.rawQuery(
        '''
        SELECT MAX(number)
        FROM circuits
        WHERE project_id = ?
        ''',
        [projectId],
      ),
    );

    if (result == null) {
      return 1;
    }

    return result + 1;
  }
}