import 'dart:async';
import 'dart:io';
import 'package:flutter_votlin_app/data/core/database/sqlite_tables.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  final String databaseName = "default.db";

  Database _db;

  Database get db => _db;

  Future init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    for (var createTable in SqliteTables.getCreateTables()) {
      await db.execute(createTable);
    }
  }

  Future<List<Map<String, dynamic>>> get(String rawQuery) async {
    var result = await _db.rawQuery(rawQuery);
    if (result.length == 0) {
      return [];
    } else {
      return result;
    }
  }

  Future<bool> insertAll(
      String tableName, List<Map<String, dynamic>> mapList) async {
    await db.transaction((txn) async {
      for (var map in mapList) {
        await txn.insert(tableName, map);
      }
    });
    return Future.value(true);
  }

  Future<bool> insertOrReplace(
      String tableName, Map<String, dynamic> map) async {
    String columnNames = map.keys.join(",");
    String columnValues = map.values.join(",");
    await db.rawInsert(
        "INSERT OR REPLACE INTO $tableName($columnNames) VALUES($columnValues)");
    return Future.value(true);
  }

  Future<bool> delete(
      String tableName, String columnId, Map<String, dynamic> map) async {
    var columnValue = map[columnId];
    await db.delete(tableName, where: "$columnId = $columnValue");
    return Future.value(true);
  }

  Future<bool> deleteAll(String tableName) async {
    await db.delete(tableName);
    return Future.value(true);
  }
}
