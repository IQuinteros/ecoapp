import 'package:flutter/material.dart';

abstract class BaseModel{
  late int id;

  BaseModel({required this.id});

  Map<String, dynamic> toJson();
}

abstract class TagModel{

  late int _id;
  late String _title;

  @protected
  void initTagging({required int newID, required String newTitle}){
    _id = newID;
    _title = newTitle;
  }

  String _tag = '';
  set tag(String newTag) => _tag = this._id.toString() + this._title + newTag;
  String get tag => _tag;
}