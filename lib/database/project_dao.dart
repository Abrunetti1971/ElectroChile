import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/project.dart';
import 'app_database.dart';

class ProjectDao {
  ProjectDao._();

  static final ProjectDao instance = ProjectDao._();

  Future<List<Project>> getAll() async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'projects',
      orderBy: 'created_at DESC',
    );

    debugPrint('========================================');
    debugPrint('PROYECTOS ENCONTRADOS: ${result.length}');
    debugPrint('========================================');

    return result.map(Project.fromMap).toList();
  }

  Future<void> insert(Project project) async {
    final db = await AppDatabase.instance.database;

    await db.insert(
      'projects',
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('========================================');
    debugPrint('PROYECTO INSERTADO');
    debugPrint(project.name);
    debugPrint('========================================');
  }

  Future<void> update(Project project) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      'projects',
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );

    debugPrint('PROYECTO ACTUALIZADO');
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;

    await db.delete(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
    );

    debugPrint('PROYECTO ELIMINADO');
  }

  Future<Project?> getById(String id) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Project.fromMap(result.first);
  }

  Future<List<Project>> search(String text) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'projects',
      where: '''
name LIKE ?
OR client LIKE ?
OR address LIKE ?
OR city LIKE ?
''',
      whereArgs: [
        '%$text%',
        '%$text%',
        '%$text%',
        '%$text%',
      ],
      orderBy: 'created_at DESC',
    );

    return result.map(Project.fromMap).toList();
  }
}