class DatabaseTables {
  DatabaseTables._();

  //==============================================================
  // PROYECTOS
  //==============================================================

  static const String projects = '''
CREATE TABLE projects(
  id TEXT PRIMARY KEY,

  name TEXT NOT NULL,
  client TEXT NOT NULL,

  address TEXT NOT NULL,
  city TEXT NOT NULL,
  region TEXT NOT NULL,

  distributor TEXT NOT NULL,

  notes TEXT NOT NULL,

  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
''';

  //==============================================================
  // CIRCUITOS
  //==============================================================

  static const String circuits = '''
CREATE TABLE circuits(

  id TEXT PRIMARY KEY,

  project_id TEXT NOT NULL,

  number INTEGER NOT NULL DEFAULT 1,

  name TEXT NOT NULL,

  type TEXT NOT NULL,

  voltage REAL NOT NULL,

  phases INTEGER NOT NULL DEFAULT 1,

  power REAL NOT NULL,

  current REAL NOT NULL,

  power_factor REAL NOT NULL DEFAULT 1.0,

  demand_factor REAL NOT NULL DEFAULT 1.0,

  length REAL NOT NULL,

  conductor_material TEXT NOT NULL,

  conductor_section REAL NOT NULL,

  conduit TEXT NOT NULL DEFAULT '',

  protection TEXT NOT NULL,

  differential TEXT NOT NULL DEFAULT '',

  earth TEXT NOT NULL DEFAULT '',

  status TEXT NOT NULL DEFAULT 'OK',

  notes TEXT NOT NULL,

  created_at TEXT NOT NULL,

  updated_at TEXT NOT NULL,

  FOREIGN KEY(project_id)
    REFERENCES projects(id)
    ON DELETE CASCADE

);
''';
}