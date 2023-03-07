import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'scheda.dart';

class SchedeBD {
  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypen = 'TEXT';
    const intType = 'INTEGER NOT NULL';

    return openDatabase(join(path, "dbschede.db"),
        onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE $table(
              id $idType,
              nomeEsercizio $textType,
              ripetizioni $intType,
              serie $intType,
              tempoPausa $intType,
              nomeScheda $textType,
              carichi $textTypen,
              appunti $textTypen 
            )
          ''');
    }, version: 1);
  }

  Future<int> createItem(Scheda scheda) async {
    final Database db = await initializeDb();
    final id = await db.insert('Schede', scheda.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Scheda>> getSchede() async {
    final db = await initializeDb();
    final List<Map<String, dynamic>> results = await db.query("Schede");
    return results.map((e) => Scheda.fromMap(e)).toList();
  }
}
