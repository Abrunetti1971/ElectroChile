class DatabaseTables {
  DatabaseTables._();

  static const projects = '''
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

  static const circuits = '''
CREATE TABLE circuits(
  id TEXT PRIMARY KEY,
  project_id TEXT NOT NULL,
  name TEXT NOT NULL,
  type INTEGER NOT NULL,
  voltage REAL NOT NULL,
  power REAL NOT NULL,
  current REAL NOT NULL,
  length REAL NOT NULL,
  conductor TEXT NOT NULL,
  breaker TEXT NOT NULL,
  differential TEXT NOT NULL,
  voltage_drop REAL NOT NULL,
  observations TEXT NOT NULL,
  FOREIGN KEY(project_id) REFERENCES projects(id)
);
''';

  static const panels = '''
CREATE TABLE panels(
  id TEXT PRIMARY KEY,
  project_id TEXT NOT NULL,
  name TEXT NOT NULL,
  voltage REAL NOT NULL,
  breaker TEXT NOT NULL,
  FOREIGN KEY(project_id) REFERENCES projects(id)
);
''';

  static const feeders = '''
CREATE TABLE feeders(
  id TEXT PRIMARY KEY,
  project_id TEXT NOT NULL,
  panel_id TEXT NOT NULL,
  name TEXT NOT NULL,
  voltage REAL NOT NULL,
  current REAL NOT NULL,
  length REAL NOT NULL,
  conductor TEXT NOT NULL,
  breaker TEXT NOT NULL,
  voltage_drop REAL NOT NULL,
  FOREIGN KEY(project_id) REFERENCES projects(id),
  FOREIGN KEY(panel_id) REFERENCES panels(id)
);
''';
}