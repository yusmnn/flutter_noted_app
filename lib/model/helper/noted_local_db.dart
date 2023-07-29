import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../noted.dart';

class NotedLocalDB {
  final String dbName = 'noted_local_db';
  final String tableName = 'notes';

  //* create table database
  Future<Database> initNotedLocalDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          Create Table $tableName (
          id Integer primary key autoincrement,
          title text not null,
          description text not null,
          createdTime text not null
          )
          ''',
        );
      },
      version: 1,
    );
  }

  //* insert() untuk menyimpan Map di table Notes
  Future<void> insertNoted(Noted noted) async {
    final db = await initNotedLocalDb();

    await db.insert(
      tableName,
      noted.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //* read data di database
  Future<List<Noted>> getAllNoted() async {
    final db = await initNotedLocalDb();
    final List<Map<String, dynamic>> result = await db.query(tableName);
    return List.generate(result.length, (index) {
      return Noted.fromMap(result[index]);
    });
  }

  //*Update data note di database
  Future<void> updateNoted(Noted noted) async {
    final db = await initNotedLocalDb();
    await db.update(
      tableName,
      noted.toMap(),
      where: 'id = ?',
      whereArgs: [noted.id],
    );
  }

  //*Delete data note di database
  Future<void> deleteNoted(int id) async {
    final db = await initNotedLocalDb();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
