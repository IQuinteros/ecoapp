import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/base.dart';

class FavoriteModel extends BaseModel
{
  late DateTime createdDate;
  late ArticleModel article;

  FavoriteModel({
    required int id,
    required this.article,
    required this.createdDate,
  }) : super(id: id);

  FavoriteModel.fromJsonMap(Map<String, dynamic> json) : super(id: json['id']){
    createdDate           = json['createdDate'];
    article               = json['article'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'id'          : id,
    'article'     : article,
    'createdDate' : createdDate
  };
}