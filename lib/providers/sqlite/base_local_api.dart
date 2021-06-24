import 'dart:async';

import 'package:flutter_ecoapp/models/base.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/widgets.dart';

abstract class BaseLocalAPI <T extends BaseModel>{
  Future<Database>? database;
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

    try{
      database = openDatabase(
        join(await getDatabasesPath(), '${tableName}_database.db'),

        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $tableName($params)',
          );
        },
        version: 1,
      );   
    } catch(e, stacktrace){
      print(e);
      print(stacktrace);
    }
  }

  Future<void> update(T item) async {
    if(database == null) await initialize();
    final db = await database!;

    try{
      await db.update(
        tableName,
        toMapFunction(item),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } catch(e, stacktrace){
      print(e);
      print(stacktrace);
    }
  }

  Future<void> clear() async{
    final items = await select();
    items.forEach((element) async => delete(element.id));
  }

  Future<void> delete(int id, {Map<String, dynamic> custom = const {}}) async {
    if(database == null) await initialize();
    final db = await database!;

    try{
      String whereStr = '';
      if(custom.entries.length > 0) custom.keys.forEach((element) { whereStr = whereStr + element + ' = ? AND';});
      await db.delete(
        tableName,
        where: custom.entries.length > 0? whereStr.substring(0, whereStr.length - 3) : 'id = ?',
        whereArgs: (custom.entries.length > 0)? custom.values.toList() : [id]
      );
    } catch(e, stacktrace){
      print(e);
      print(stacktrace);
    }
  }

  Future<void> insert(T item) async {
    if(database == null) await initialize();
    final db = await database!;

    try{
      await db.insert(
        tableName,
        toMapFunction(item),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch(e, stacktrace){
      print(e);
      print(stacktrace);
    }
  }
  
  Future<List<T>> select() async {
    if(database == null) await initialize();
    final db = await database!;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    try{
      return List.generate(maps.length, (i) {
        return constructor(maps[i]);
      });
    } catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return [];
    }
  }

}
