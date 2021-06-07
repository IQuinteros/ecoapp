import 'dart:async';

import 'package:flutter_ecoapp/models/base.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/widgets.dart';

abstract class BaseLocalAPI <T extends BaseModel>{
  late Future<Database> database;
  final String tableName;
  final String params;

  Map<String, dynamic> Function(T) toMapFunction;
  T Function(Map<String, dynamic>) constructor;

  BaseLocalAPI({
    required this.tableName, 
    required this.params,
    required this.toMapFunction,
    required this.constructor
  });

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = openDatabase(
      join(await getDatabasesPath(), '${tableName}_database.db'),

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName($params)',
        );
      },
      version: 1,
    );    
  }

  Future<void> updateDog(T item) async {
    final db = await database;

    await db.update(
      tableName,
      toMapFunction(item),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insert(T item) async {
    final db = await database;

    await db.insert(
      tableName,
      toMapFunction(item),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<List<T>> select() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return constructor(maps[i]);
    });
  }

}
