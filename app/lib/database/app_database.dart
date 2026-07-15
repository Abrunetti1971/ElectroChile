import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_migrations.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();

    return _database!;
  }

  Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();

    final path = join(
      databasesPath,
      'electrochile.db',
    );

    return openDatabase(
      path,
      version: DatabaseMigrations.currentVersion,
      onCreate: DatabaseMigrations.onCreate,
      onUpgrade: DatabaseMigrations.onUpgrade,
      onDowngrade: DatabaseMigrations.onDowngrade,
    );
  }

  Future<void> close() async {
    if (_database == null) return;

    await _database!.close();

    _database = null;
  }

  Future<void> deleteDatabaseFile() async {
    final databasesPath = await getDatabasesPath();

    final path = join(
      databasesPath,
      'electrochile.db',
    );

    await deleteDatabase(path);

    _database = null;
  }
}