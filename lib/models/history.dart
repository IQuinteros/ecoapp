import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class HistoryModel extends BaseModel
{
  DateTime createdDate;
  ArticleModel article;

  HistoryModel({
    required int id,
    required this.article,
    required this.createdDate,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id'            : id,
    'article'       : article,
    'createdDate'   : createdDate
  };
}

class HistoryDetailModel extends BaseModel
{
  DateTime date;
  bool deleted;

  HistoryDetailModel({
    required int id,
    required this.date,
    required this.deleted
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id'      : id,
    'date'    : date,
    'deleted' : deleted
  };
}