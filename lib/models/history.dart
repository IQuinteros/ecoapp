import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class HistoryModel extends BaseModel
{
  late DateTime createdDate;
  late ArticleModel article;

  HistoryModel({
    required int id,
    required this.article,
    required this.createdDate,
  }) : super(id: id);

  HistoryModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    createdDate           = json['createdDate'];
    article               = json['article'];
  }

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