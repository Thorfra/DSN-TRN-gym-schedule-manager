import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'scheda/scheda.dart';
import 'esercizio/esercizio.dart';
import 'dart:async';

class DbHelper {
  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypen = 'TEXT';
    const intType = 'INTEGER NOT NULL';

    return openDatabase(join(path, "dbPalestra.db"),
        onCreate: (db, version) async {
      await db.execute("""CREATE TABLE IF NOT EXISTS Schede(
              id $idType,
              nomeScheda $textType
            );""");

      await db.execute("""
            CREATE TABLE IF NOT EXISTS Esercizi(
              id $idType,
              nomeEsercizio $textType,
              ripetizioni $intType,
              serie $intType,
              tempoPausa $intType,
              idScheda $intType,
              carichi $textTypen,
              appunti $textTypen,
              FOREIGN KEY (idScheda) REFERENCES Schede(id) 
            );""");
    }, version: 1);
  }

  Future<int> createEsercizio(Esercizio esercizio) async {
    final Database db = await initializeDb();
    final id = await db.insert('Esercizi', esercizio.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Esercizio>> getEsercizi() async {
    final db = await initializeDb();
    final List<Map<String, dynamic>> results = await db.query("Esercizi");
    return results.map((e) => Esercizio.fromMap(e)).toList();
  }

  Future<int> removeEsercizio(id) async {
    final Database db = await initializeDb();
    final idRimosso =
        await db.delete('Esercizi', where: "id=?", whereArgs: [id]);
    return idRimosso;
  }

  Future<int> createScheda(Scheda scheda) async {
    final Database db = await initializeDb();
    final id = await db.insert('Schede', scheda.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> removeScheda(id) async {
    final Database db = await initializeDb();
    final idRimosso = await db.delete('Schede', where: "id=?", whereArgs: [id]);
    return idRimosso;
  }

  Future<List<Scheda>> getSchede() async {
    final db = await initializeDb();
    final List<Map<String, dynamic>> results = await db.query("Schede");
    return results.map((e) => Scheda.fromMap(e)).toList();
  }
}
