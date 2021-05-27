import 'package:flutter/material.dart';

abstract class BaseModel{
  int id;

  BaseModel({@required this.id});
}

abstract class TagModel{

  int _id;
  String _title;

  void initTagging({int newID, String newTitle}){
    _id = newID;
    _title = newTitle;
  }

  String _tag = '';
  set tag(String newTag) => _tag = this._id.toString() + this._title + newTag;
  String get tag => _tag;
}