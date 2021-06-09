import 'dart:html';

import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class HistoryModel extends BaseModel
{
  late DateTime createdDate;
  late ArticleModel article;
  late bool deleted;

  HistoryModel({
    required int id,
    required this.article,
    required this.createdDate,
    required this.deleted
  }) : super(id: id);

  HistoryModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    createdDate           = json['created_date'];
    article               = json['article'];
    deleted               = json['article'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'            : id,
    'article'       : article,
    'created_date'   : createdDate
  };
}

class HistoryDetailModel extends BaseModel
{
  late DateTime date;
  late HistoryModel history;
  
  HistoryDetailModel({
    required int id,
    required this.date,
    required this.history
  }) : super(id: id);

  HistoryDetailModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    date           = json['created_date'];
    history        = json['history_id'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'      : id,
    'date'    : date,
    'history_id': history.id
  };
}