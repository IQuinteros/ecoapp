import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class HistoryModel extends BaseModel
{
  late DateTime createdDate;
  late int articleId;
  late bool deleted;

  HistoryModel({
    required int id,
    required this.articleId,
    required this.createdDate,
    required this.deleted
  }) : super(id: id);

  HistoryModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    createdDate           = DateTime.parse(json['creation_date']);
    articleId             = json['article_id'];
    deleted               = json['deleted'] != 0;
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'              : id,
    'article_id'      : articleId,
    'creation_date'    : createdDate.toString(),
    'deleted'         : deleted
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
    date           = DateTime.parse(json['creation_date']);
    history        = json['history_id'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'      : id,
    'creation_date'    : date.toString(),
    'history_id': history.id
  };
}