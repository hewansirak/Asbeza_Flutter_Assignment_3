import 'db_connect.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection? _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _databaseConnection!.setDatabase();
    return _database!;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDataId(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        .rawUpdate('UPDATE $table SET quantity = ? WHERE id = ?', [
      data['quantity'],
      data['id'],
    ]);
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id=$itemId");
  }

  deleteAllData(table) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table");
  }
}