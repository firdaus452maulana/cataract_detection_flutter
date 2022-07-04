import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DiagnosisDatabase {
  static final DiagnosisDatabase instance = DiagnosisDatabase._init();

  static Database _database;

  DiagnosisDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('diagnosis.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {}

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
