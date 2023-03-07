import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'scheda.dart';

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
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypen = 'TEXT';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $table(
        ${CampiScheda.id} $idType,
        ${CampiScheda.nomeEsercizio} $textType,
        ${CampiScheda.ripetizioni} $intType,
        ${CampiScheda.serie} $intType,
        ${CampiScheda.tempoPausa} $intType,
        ${CampiScheda.nomeScheda} $textType,
        ${CampiScheda.carichi} $textTypen,
        ${CampiScheda.appunti} $textTypen 
      )
    ''');
  }

  Future<Scheda> create(Scheda scheda) async {
    final db = await instance.database;
    final id = await db.insert(table, scheda.toJson());
    return scheda.copy(id: id);
  }

  Future<Scheda> readScheda(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      table,
      columns: CampiScheda.values,
      where: '${CampiScheda.id}=?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Scheda.fromJson(maps.first);
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
