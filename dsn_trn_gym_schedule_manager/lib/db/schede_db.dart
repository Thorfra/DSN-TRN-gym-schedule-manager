import 'package:path/path.dart';
import 'package:dsn_trn_gym_schedule_manager1/db/scheda.dart';

class SchedeBD {
  static final SchedeBD instance = SchedeBD._init();

  static Database? _database;

  SchedeBD._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('schede.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
